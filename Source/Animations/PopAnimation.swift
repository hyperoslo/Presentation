import UIKit

public class PopAnimation: NSObject, Animation {

  let content: Content
  let duration: NSTimeInterval

  public init(content: Content, duration: NSTimeInterval = 1.0) {
    self.content = content
    self.duration = duration

    content.view.hidden = true
    
    super.init()
  }

  private func animate() {
    let view = content.view
    if view.hidden {
      view.transform = CGAffineTransformMakeScale(0.6, 0.6)
    }
    view.hidden = false

    UIView.animateWithDuration(duration,
      animations: {
        view.transform = CGAffineTransformMakeScale(1.05, 1.05)
        view.alpha = 0.8
      }, completion: { done in
        UIView.animateWithDuration(1 / 8.0,
          animations: {
            view.transform = CGAffineTransformMakeScale(0.9, 0.9)
            view.alpha = 0.9
          }, completion: { done in
            UIView.animateWithDuration(1 / 4.0,
              animations: {
                view.transform = CGAffineTransformIdentity
                view.alpha = 1.0
              }, completion: nil)
        })
    })
  }
}

// MARK: TutorialAnimation protocol implementation

extension PopAnimation {

  public func play() {
    if content.view.superview != nil {
      content.view.hidden = true
      animate()
    }
  }

  public func playBack() {
    if content.view.superview != nil {
      content.view.hidden = false
      animate()
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
