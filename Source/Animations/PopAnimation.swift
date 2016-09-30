import UIKit

public class PopAnimation: NSObject, Animatable {

  let content: Content
  let duration: TimeInterval
  var initial: Bool
  var played = false

  public init(content: Content, duration: TimeInterval = 1.0, initial: Bool = false) {
    self.content = content
    self.duration = duration
    self.initial = initial

    content.view.isHidden = true

    super.init()
  }

  fileprivate func animate() {
    let view = content.view
    if view.isHidden {
      view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    }
    view.isHidden = false

    UIView.animate(withDuration: duration,
      animations: {
        view.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        view.alpha = 0.8
      }, completion: { _ in
        UIView.animate(withDuration: 0.1,
          animations: {
            view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            view.alpha = 0.9
          }, completion: { _ in
            UIView.animate(withDuration: 0.1,
              animations: {
                view.transform = CGAffineTransform.identity
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
        content.view.isHidden = true
        animate()
      }
    }
  }

  public func playBack() {
    if content.view.superview != nil {
      if !(initial && played) {
        content.view.isHidden = false
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
