import UIKit

extension CGRect {

  var rotatedRect: CGRect {
    var rotatedRect = self
    rotatedRect.size = CGSize(width: CGRectGetHeight(self),
      height: CGRectGetWidth(self))
    return rotatedRect
  }
}
