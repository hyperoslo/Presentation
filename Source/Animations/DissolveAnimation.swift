import UIKit

public class DissolveAnimation: NSObject, Animatable {
  private let content: Content
  private let duration: TimeInterval
  private let delay: TimeInterval
  private var initial: Bool
  private var played = false

  public init(content: Content,
              duration: TimeInterval = 1.0,
              delay: TimeInterval = 0.0,
              initial: Bool = false) {
      self.content = content
      self.duration = duration
      self.delay = delay
      self.initial = initial

      content.view.alpha = 0.0

      super.init()
  }

  private func animate() {
    let alpha: CGFloat = content.view.alpha == 0.0 ? 1.0 : 0.0

    UIView.animate(
      withDuration: duration,
      delay: delay,
      usingSpringWithDamping: 1.0,
      initialSpringVelocity: 0.5,
      options: [.beginFromCurrentState, .allowUserInteraction],
      animations: ({ [unowned self] in
        self.content.view.alpha = alpha
      }),
      completion: nil
    )

    played = true
  }
}

// MARK: - Animatable

extension DissolveAnimation {
  public func play() {
    if content.view.superview != nil {
      if !(initial && played) {
        content.view.alpha = 0.0
        animate()
      }
    }
  }

  public func playBack() {
    if content.view.superview != nil {
      if !(initial && played) {
        content.view.alpha = 1.0
        animate()
      }
    }
  }

  public func moveWith(offsetRatio: CGFloat) {
    let view = content.view

    if view.layer.animationKeys() == nil {
      if view.superview != nil {
        let ratio = offsetRatio > 0.0 ? offsetRatio : (1.0 + offsetRatio)
        view.alpha = max(0.0, min(1.0, ratio))
      }
    }
  }
}
