import UIKit

public class PopAnimation: NSObject, Animatable {

  let content: Content
  let duration: NSTimeInterval
  var initial: Bool
  var played = false

  public init(content: Content, duration: NSTimeInterval = 1.0, initial: Bool = false) {
    self.content = content
    self.duration = duration
    self.initial = initial

    content.view.hidden = true

    super.init()
  }

  private func animate() {
    let view = content.view
    if view.hidden {
      view.transform = CGAffineTransformMakeScale(0.95, 0.95)
    }
    view.hidden = false

    UIView.animateWithDuration(duration,
      animations: {
        view.transform = CGAffineTransformMakeScale(1.05, 1.05)
        view.alpha = 0.8
      }, completion: { _ in
        UIView.animateWithDuration(0.1,
          animations: {
            view.transform = CGAffineTransformMakeScale(0.95, 0.95)
            view.alpha = 0.9
          }, completion: { _ in
            UIView.animateWithDuration(0.1,
              animations: {
                view.transform = CGAffineTransformIdentity
                view.alpha = 1.0
              }, completion: nil)
        })
    })

    played = true
  }
}

// MARK: - Animatable

extension PopAnimation {

  public func play() {
    if content.view.superview != nil {
      if !(initial && played) {
        content.view.hidden = true
        animate()
      }
    }
  }

  public func playBack() {
    if content.view.superview != nil {
      if !(initial && played) {
        content.view.hidden = false
        animate()
      }
    }
  }

  public func moveWith(offsetRatio: CGFloat) {
    let view = content.view
    if view.layer.animationKeys() == nil {
      if view.superview != nil {
        let ratio = offsetRatio > 0.0 ? offsetRatio : (1.0 + offsetRatio)
        view.alpha = ratio
      }
    }
  }
}
