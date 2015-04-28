import UIKit

@objc public class PopAppearanceAnimation: NSObject, TutorialAnimation {

  public var view: UIView
  public var destination: TutorialViewPosition
  public var duration: NSTimeInterval
  public var isPlaying = false

  init(view: UIView, destination: TutorialViewPosition, duration: NSTimeInterval = 0.5) {
    self.view = view
    self.view.setTranslatesAutoresizingMaskIntoConstraints(true)
    self.destination = destination
    self.duration = duration

    super.init()
  }

  func animate(alpha: CGFloat) {
    if !isPlaying {
      isPlaying = true

      UIView.animateWithDuration(duration,
        animations: {
          [unowned self] () -> Void in
          self.view.alpha = alpha
        }, completion: {
          [unowned self] (done: Bool) -> Void in
          self.isPlaying = false
        })
    }
  }
}

// MARK: TutorialAnimation protocol implementation

extension PopAppearanceAnimation {

  public func rotate() {
    if let superview = view.superview {
      var frame = view.frame
      var rotatedFrame = superview.bounds.rotatedRect

      frame.origin = destination.originInFrame(rotatedFrame)
      view.frame = frame
    }
  }

  public func show() {
    var frame = view.frame
    if let superview = view.superview {
      frame.origin.x = destination.xInFrame(superview.frame)
      frame.origin.y = destination.yInFrame(superview.frame)
    }

    view.frame = frame
    view.alpha = 0.0
  }

  public func play() {
    animate(1.0)
  }

  public func playBack() {
    animate(0.0)
  }

  public func move(offsetRatio: CGFloat) {
    if !isPlaying {
      view.alpha = offsetRatio
    }
  }
}
