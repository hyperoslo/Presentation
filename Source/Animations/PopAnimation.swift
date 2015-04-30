import UIKit

@objc public class PopAppearanceAnimation: NSObject, Animation {

  public var view: UIView
  public var destination: Position
  public var duration: NSTimeInterval

  public init(view: UIView, destination: Position, duration: NSTimeInterval = 0.5) {
    self.view = view
    self.view.setTranslatesAutoresizingMaskIntoConstraints(true)
    self.view.hidden = true
    self.destination = destination
    self.duration = duration

    super.init()
  }

  private func animate() {
    if view.hidden {
      view.transform = CGAffineTransformMakeScale(0.6, 0.6)
    }
    view.hidden = false

    UIView.animateWithDuration(duration,
      animations: { [unowned self] in
        self.view.transform = CGAffineTransformMakeScale(1.05, 1.05)
        self.view.alpha = 0.8
      }, completion: { [unowned self] done in
        UIView.animateWithDuration(1 / 8.0,
          animations: { [unowned self] in
            self.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
            self.view.alpha = 0.9
          }, completion: { [unowned self] done in
            UIView.animateWithDuration(1 / 4.0,
              animations: { [unowned self] in
                self.view.transform = CGAffineTransformIdentity
                self.view.alpha = 1.0
              }, completion: nil)
          })
      })
  }
}

// MARK: TutorialAnimation protocol implementation

extension PopAppearanceAnimation {

  public func play() {
    if view.superview != nil {
      view.hidden = true
      view.placeAtPosition(destination)
      animate()
    }
  }

  public func playBack() {
    if view.superview != nil {
      view.hidden = false
      animate()
    }
  }

  public func move(offsetRatio: CGFloat) {
    if view.layer.animationKeys() == nil {
      if view.superview != nil {
        let ratio = offsetRatio > 0.0 ? offsetRatio : (1.0 + offsetRatio)
        view.alpha = ratio
      }
    }
  }

  public func rotate() {
    view.rotateAtPosition(destination)
  }
}
