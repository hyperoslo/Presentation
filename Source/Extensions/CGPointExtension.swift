import UIKit

public extension CGPoint {

  public func positionInFrame(frame: CGRect) -> Position {
    let left = x / CGRectGetWidth(frame)
    let top = y / CGRectGetHeight(frame)

    return Position(left: left, top: top)
  }
}
