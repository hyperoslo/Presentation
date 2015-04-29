import UIKit

@objc public class TransitionAnimation: NSObject, Animation {

  public var view: UIView
  public var destination: Position
  public var duration: NSTimeInterval

  var start: Position?

  public init(view: UIView, destination: Position, duration: NSTimeInterval = 0.5) {
    self.view = view
    self.view.setTranslatesAutoresizingMaskIntoConstraints(true)
    self.destination = destination
    self.duration = duration

    super.init()
  }

  private func animate(frame: CGRect) {
    UIView.animateWithDuration(duration, delay: 0,
      options: .BeginFromCurrentState,
      animations: { [unowned self] in
        self.view.frame = frame
      }, completion: nil)
  }

  private func startFrameInSuperview(superview: UIView) -> CGRect {
    let bounds = superview.bounds
    if start == nil {
      start = view.frame.origin.positionInFrame(bounds)
    }

    var frame = view.frame
    frame.origin = start!.originInFrame(bounds)
    return frame
  }
}

// MARK: TutorialAnimation protocol implementation

extension TransitionAnimation {

  public func play() {
    if let superview = view.superview {
      view.frame = startFrameInSuperview(superview)
      var frame = view.frame
      frame.origin = destination.originInFrame(superview.bounds)

      animate(frame)
    }
  }

  public func playBack() {
    if let superview = view.superview {
      var frame = startFrameInSuperview(superview)

      animate(frame)
    }
  }

  public func move(offsetRatio: CGFloat) {
    if view.layer.animationKeys() == nil {
      if let superview = view.superview {
        let startFrame = startFrameInSuperview(superview)
        let startX = CGRectGetMinX(startFrame)
        let dx = destination.xInFrame(superview.bounds) - startX

        let ratio = offsetRatio > 0.0 ? offsetRatio : (1.0 + offsetRatio)
        let offset = dx * ratio

        var frame = view.frame
        frame.origin.x = startX + offset

        view.frame = frame
      }
    }
  }

  public func rotate() {
    view.rotateAtPosition(destination)
  }
}
