import UIKit

@objc public class LeftAppearanceAnimation: TransitionAnimation {

  struct Dimensions {
    static let defaultOffset: CGFloat = 50.0
  }

  public func placeView() {
    var frame = view.frame
    if let superview = view.superview {
      frame.origin.x = CGRectGetMinX(superview.frame) - Dimensions.defaultOffset
      frame.origin.y = destination.yInFrame(superview.bounds)
    }
    view.frame = frame
  }
}

// MARK: TutorialAnimation protocol implementation

extension LeftAppearanceAnimation {

  public override func play() {
    placeView()

    super.play()
  }

  public override func move(offsetRatio: CGFloat) {
    placeView()

    super.move(offsetRatio)
  }
}
