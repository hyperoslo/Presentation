import UIKit

@objc public class TransitionAnimation: NSObject, TutorialAnimation {

  public var view: UIView
  public var destination: TutorialViewPosition
  public var duration: NSTimeInterval
  public var isPlaying = false

  private var start: CGPoint?

  var distance: CGFloat {
    var dx: CGFloat = 0.0

    if let superview = view.superview {
      dx = destination.xInView(superview)
      if let start = start {
        dx -= start.x
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

  public func play() {
    if let superview = view.superview {
      var frame = view.frame
      if start == nil {
        start = frame.origin
      }
      frame.origin = destination.originInView(superview)

      animate(frame)
    }
  }

  public func playBack() {
    if let superview = view.superview, start = start {
      var frame = view.frame
      frame.origin = start

      animate(frame)
    }
  }

  public func move(offsetRatio: CGFloat) {
    if !isPlaying {
      if let superview = view.superview {
        var frame = view.frame
        if start == nil {
          start = frame.origin
        }

        let ratio = offsetRatio > 0.0 ? offsetRatio : (1.0 + offsetRatio)
        let offset = distance * ratio

        frame.origin.x = start!.x + offset

        view.frame = frame
      }
    }
  }
}
