import UIKit

extension UIView {

  public func placeAtPosition(position: Position) {
    if let superview = superview {
      frame.origin = position.originInFrame(superview.bounds)
    }
  }

  public func rotateAtPosition(position: Position) {
    if let superview = superview {
      var rotatedFrame = superview.bounds.rotatedRect
      frame.origin = position.originInFrame(rotatedFrame)
    }
  }
}
