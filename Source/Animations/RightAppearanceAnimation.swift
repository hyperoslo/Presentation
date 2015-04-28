import UIKit

@objc public class RightAppearanceAnimation: TransitionAnimation {

  struct Dimensions {
    static let defaultOffset: CGFloat = 50.0
  }

  private func placeView() {
    var frame = view.frame
    if let superview = view.superview {
      frame.origin.x = CGRectGetMaxX(superview.frame) + Dimensions.defaultOffset
      frame.origin.y = destination.yInFrame(superview.bounds)
    }
    view.frame = frame
  }
}

// MARK: TutorialAnimation protocol implementation

extension RightAppearanceAnimation {

  public override func play() {
    placeView()

    super.play()
  }

  public override func move(offsetRatio: CGFloat) {
    placeView()

    super.move(offsetRatio)
  }
}

