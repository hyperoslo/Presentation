import UIKit

public extension CGPoint {

  public func position(in frame: CGRect) -> Position {
    let left = x / frame.width
    let top = y / frame.height

    return Position(left: left, top: top)
  }
}
