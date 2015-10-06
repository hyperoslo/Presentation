import UIKit

public class TransitionAnimation: NSObject, Animatable {

  let content: Content
  let destination: Position
  let duration: NSTimeInterval
  let dumping: CGFloat
  var reflective: Bool
  var initial: Bool
  var played = false

  lazy var start: Position = { [unowned self] in
    return self.content.position.positionCopy
    }()

  lazy var startMirror: Position = { [unowned self] in
    return self.start.horizontalMirror
    }()

  public init(content: Content, destination: Position,
    duration: NSTimeInterval = 1.0, dumping: CGFloat = 0.7, reflective: Bool = false, initial: Bool = false) {
      self.content = content
      self.destination = destination
      self.duration = duration
      self.dumping = dumping
      self.reflective = reflective
      self.initial = initial

      super.init()
  }

  private func animateTo(position: Position) {
    UIView.animateWithDuration(duration,
      delay: 0,
      usingSpringWithDamping: dumping,
      initialSpringVelocity: 0.5,
      options: [.BeginFromCurrentState, .AllowUserInteraction],
      animations: { [unowned self] in
        self.content.position = position
        self.content.animate()
      }, completion: nil)

    played = true
  }
}

// MARK: -  Animatable

extension TransitionAnimation {

  public func play() {
    if let _ = content.view.superview {
      if !(initial && played) {
        let position = reflective ? startMirror : start

        content.position = position
        content.animate()

        animateTo(destination)
      }
    }
  }

  public func playBack() {
    if let _ = content.view.superview {
      if !(initial && played) {
        let position = reflective ? startMirror : start

        animateTo(position)
      }
    }
  }

  public func moveWith(offsetRatio: CGFloat) {
    if content.view.layer.animationKeys() == nil {
      let view = content.view

      if let superview = view.superview {
        let position = reflective && offsetRatio < 0.0 ? startMirror : start

        let startX = position.xInFrame(superview.bounds)
        let dx = destination.xInFrame(superview.bounds) - startX

        let startY = position.yInFrame(superview.bounds)
        let dy = destination.yInFrame(superview.bounds) - startY

        let ratio = offsetRatio > 0.0 ? offsetRatio : (1.0 + offsetRatio)
        let offsetX = dx * ratio
        let offsetY = dy * ratio

        var origin = content.position.originInFrame(superview.bounds)
        origin.x = startX + offsetX
        origin.y = startY + offsetY

        content.position = origin.positionInFrame(superview.bounds)
      }
    }
  }
}
