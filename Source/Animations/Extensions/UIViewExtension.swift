import UIKit

extension UIView {

  func placeAtPosition(position: TutorialViewPosition) {
    if let superview = superview {
      frame.origin = position.originInFrame(superview.bounds)
    }
  }

  func rotateAtPosition(position: TutorialViewPosition) {
    if let superview = superview {
      var rotatedFrame = superview.bounds.rotatedRect
      frame.origin = position.originInFrame(rotatedFrame)
    }
  }
}
