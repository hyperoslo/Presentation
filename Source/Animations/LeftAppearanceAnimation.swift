import UIKit

@objc public class LeftAppearanceAnimation: TransitionAnimation {

  struct Dimensions {
    static let defaultOffset: CGFloat = 50.0
  }
}

// MARK: TutorialAnimation protocol implementation

extension LeftAppearanceAnimation {

  public func show() {
    var frame = view.frame
    if let superview = view.superview {
      frame.origin.x = CGRectGetMinX(superview.frame) - Dimensions.defaultOffset
      frame.origin.y = destination.yInView(superview)
    }

    view.frame = frame
  }
}
