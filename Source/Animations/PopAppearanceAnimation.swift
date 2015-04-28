import UIKit

@objc public class PopAppearanceAnimation: NSObject, Animation {

  public var view: UIView
  public var destination: TutorialViewPosition
  public var duration: NSTimeInterval
  public var isPlaying = false

  init(view: UIView, destination: TutorialViewPosition, duration: NSTimeInterval = 1.0) {
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
    view.rotateAtPosition(destination)
  }

  public func show() {
    view.placeAtPosition(destination)
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
      let ratio = offsetRatio > 0.0 ? offsetRatio : (1.0 + offsetRatio)
        view.alpha = offsetRatio
    }
  }
}
