import UIKit

public class TransitionAnimation: NSObject, Animation {

  let content: Content
  var reflective = false
  var reflectionEnabled = false

  lazy var start: Position = { [unowned self] in
    return self.content.position.positionCopy
    }()

  lazy var startMirror: Position = { [unowned self] in
    return self.start.horizontalMirror
    }()

  let destination: Position
  let duration: NSTimeInterval

  public init(content: Content, destination: Position,
    duration: NSTimeInterval = 1.0, reflective: Bool = false) {
      self.content = content
      self.destination = destination
      self.duration = duration
      self.reflective = reflective

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

  private func performIfHasSuperview(perform: () -> Void) {
    if let superview = content.view.superview {
      perform()
    }
  }
}

// MARK: TutorialAnimation protocol implementation

extension TransitionAnimation {

  public func play() {
    let position = reflective ? startMirror : start

    performIfHasSuperview { [unowned self] in
      self.content.position = position
      self.animateTo(self.destination)
    }
  }

  public func playBack() {
    let position = reflective ? startMirror : start

    performIfHasSuperview { [unowned self] in
      self.animateTo(position)
    }
  }

  public func moveWith(offsetRatio: CGFloat) {
    if content.view.layer.animationKeys() == nil {
      let view = content.view

      if let superview = view.superview {
        let position = reflective && offsetRatio < 0.0 ? startMirror : start

        let startX = position.xInFrame(superview.bounds)
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
