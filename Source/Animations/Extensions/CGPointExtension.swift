import UIKit

extension CGPoint {

  func positionInFrame(frame: CGRect) -> Position {
    var left = x / CGRectGetWidth(frame)
    var top = y / CGRectGetHeight(frame)

    return Position(left: left, top: top)
  }
}
