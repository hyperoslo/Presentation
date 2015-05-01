import UIKit

public class TransitionAnimation: NSObject, Animation {

  let content: Content

  lazy var start: Position = { [unowned self] in
    return self.content.position.positionCopy
    }()

  let destination: Position
  let duration: NSTimeInterval

  var started = false

  public init(content: Content, destination: Position, duration: NSTimeInterval = 1.0) {
    self.content = content
    self.destination = destination
    self.duration = duration

    super.init()
  }

  private func animateTo(position: Position) {
    UIView.animateWithDuration(duration,
      delay: 0,
      usingSpringWithDamping: 0.7,
      initialSpringVelocity: 0.5,
      options: .BeginFromCurrentState,
      animations: { [unowned self] in
        self.content.position = position
      }, completion: nil)
  }
}

// MARK: TutorialAnimation protocol implementation

extension TransitionAnimation {

  public func play() {
    content.position = start
    animateTo(destination)
  }

  public func playBack() {
    animateTo(start)
  }

  public func moveWith(offsetRatio: CGFloat) {
    if content.view.layer.animationKeys() == nil {
      let view = content.view
      if let superview = view.superview {
        let startX = start.xInFrame(superview.bounds)
        let dx = destination.xInFrame(superview.bounds) - startX

        let ratio = offsetRatio > 0.0 ? offsetRatio : (1.0 + offsetRatio)
        let offset = dx * ratio

        var origin = content.position.originInFrame(superview.bounds)
        origin.x = startX + offset

        content.position = origin.positionInFrame(superview.bounds)
      }
    }
  }
}
