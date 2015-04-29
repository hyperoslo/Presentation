import UIKit

public extension CGPoint {

  public func positionInFrame(frame: CGRect) -> Position {
    var left = x / CGRectGetWidth(frame)
    var top = y / CGRectGetHeight(frame)

    return Position(left: left, top: top)
  }
}
