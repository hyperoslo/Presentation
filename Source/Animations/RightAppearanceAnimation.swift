import UIKit

@objc public class RightAppearanceAnimation: TransitionAnimation {

  struct Dimensions {
    static let defaultOffset: CGFloat = 50.0
  }
}

// MARK: TutorialAnimation protocol implementation

extension RightAppearanceAnimation {

  public func show() {
    var frame = view.frame
    if let superview = view.superview {
      frame.origin.x = CGRectGetMaxX(superview.frame) + Dimensions.defaultOffset
      frame.origin.y = destination.yInFrame(superview.bounds)
      start = view.frame.origin.positionInFrame(superview.bounds)
    }

    view.frame = frame
  }
}

