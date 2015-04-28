import UIKit

@objc public class TransitionAnimation: NSObject, TutorialAnimation {

  public var view: UIView
  public var destination: TutorialViewPosition
  public var duration: NSTimeInterval
  public var isPlaying = false

  var start: TutorialViewPosition?

  var startPoint: CGPoint? {
    var point: CGPoint?
    if let superview = view.superview {
      if start == nil {
        start = view.frame.origin.positionInFrame(superview.bounds)
      }
      point = start!.originInFrame(superview.bounds)
    }

    return point
  }

  var distance: CGFloat {
    var dx: CGFloat = 0.0

    if let superview = view.superview {
      dx = destination.xInFrame(superview.bounds)
      if let startPoint = startPoint {
        dx -= startPoint.x
      }
    }

    return dx
  }

  init(view: UIView, destination: TutorialViewPosition, duration: NSTimeInterval = 0.5) {
    self.view = view
    self.view.setTranslatesAutoresizingMaskIntoConstraints(true)
    self.destination = destination
    self.duration = duration

    super.init()
  }

  func animate(frame: CGRect) {
    if !isPlaying {
      isPlaying = true

      UIView.animateWithDuration(duration,
        animations: {
          [unowned self] () -> Void in
          self.view.frame = frame
        }, completion: {
          [unowned self] (done: Bool) -> Void in
          self.isPlaying = false
        })
    }
  }
}

// MARK: TutorialAnimation protocol implementation

extension TransitionAnimation {

  public func rotate() {
    if let superview = view.superview {
      var frame = view.frame
      var rotatedFrame = superview.bounds.rotatedRect

      frame.origin = destination.originInFrame(rotatedFrame)
      view.frame = frame
    }
  }

  public func play() {
    if let superview = view.superview {
      var frame = view.frame
      frame.origin = destination.originInFrame(superview.bounds)

      animate(frame)
    }
  }

  public func playBack() {
    if let startPoint = startPoint {
      var frame = view.frame
      frame.origin = startPoint

      animate(frame)
    }
  }

  public func move(offsetRatio: CGFloat) {
    if !isPlaying {
      if let startPoint = startPoint {
        var frame = view.frame

        let ratio = offsetRatio > 0.0 ? offsetRatio : (1.0 + offsetRatio)
        let offset = distance * ratio

        frame.origin.x = startPoint.x + offset

        view.frame = frame
      }
    }
  }
}
