import UIKit

extension CGRect {

  public var rotatedRect: CGRect {
    var rotatedRect = self
    rotatedRect.size = CGSize(width: CGRectGetHeight(self),
      height: CGRectGetWidth(self))

    return rotatedRect
  }
}
