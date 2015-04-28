import UIKit

@objc public class PopAppearanceAnimation: NSObject, Animation {

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

  func animate() {
    if !isPlaying {
      isPlaying = true

      if view.hidden {
        view.transform = CGAffineTransformMakeScale(0.6, 0.6)
      }
      view.hidden = false

      UIView.animateWithDuration(duration,
        animations: {
          [unowned self] in
          self.view.transform = CGAffineTransformMakeScale(1.05, 1.05)
          self.view.alpha = 0.8
        }, completion: { [unowned self] finished in
          UIView.animateWithDuration(1 / 8.0,
            animations: {
              [unowned self] in
              self.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
              self.view.alpha = 0.9
            }, completion: { [unowned self] finished in
              UIView.animateWithDuration(1 / 4.0,
                animations: {
                  [unowned self] in
                  self.view.transform = CGAffineTransformIdentity
                  self.view.alpha = 1.0
                }, completion: { [unowned self] finished in
                  self.isPlaying = false
                })
            })
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
    view.hidden = true
  }

  public func play() {
    view.hidden = true
    animate()
  }

  public func playBack() {
    view.hidden = false
    animate()
  }

  public func move(offsetRatio: CGFloat) {
    if !isPlaying {
      let ratio = offsetRatio > 0.0 ? offsetRatio : (1.0 + offsetRatio)
        view.alpha = offsetRatio
    }
  }
}
