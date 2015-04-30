import UIKit

extension UIView {

  public func placeAtPosition(position: Position) {
    if let superview = superview {
      let point = position.originInFrame(superview.bounds)

      frame.origin = point
    }
  }

  public func rotateAtPosition(position: Position) {
    if let superview = superview {
      let rotatedFrame = superview.bounds.rotatedRect
      let point = position.originInFrame(rotatedFrame)

      frame.origin = point
    }
  }

  public func alignToCenter() {
    frame.origin.x -= CGRectGetMidX(bounds)
    frame.origin.y -= CGRectGetMidY(bounds)
  }
}
