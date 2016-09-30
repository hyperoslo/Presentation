import UIKit

@objc public class Position: NSObject {

  public var left: CGFloat = 0.0
  public var top: CGFloat = 0.0

  public var right: CGFloat {
    get {
      return 1.0 - left
    }
    set {
      left = 1.0 - newValue
    }
  }

  public var bottom: CGFloat {
    get {
      return 1.0 - top
    }
    set {
      top = 1.0 - newValue
    }
  }

  public init(left: CGFloat, top: CGFloat) {
    super.init()

    self.left = left
    self.top = top
  }

  public init(left: CGFloat, bottom: CGFloat) {
    super.init()

    self.left = left
    self.bottom = bottom
  }

  public init(right: CGFloat, top: CGFloat) {
    super.init()

    self.right = right
    self.top = top
  }

  public init(right: CGFloat, bottom: CGFloat) {
    super.init()

    self.right = right
    self.bottom = bottom
  }

  public var positionCopy: Position {
    return Position(left: left, top: top)
  }

  public var horizontalMirror: Position {
    return Position(left: right, top: top)
  }

  public func originInFrame(_ frame: CGRect) -> CGPoint {
    return CGPoint(x: xInFrame(frame), y: yInFrame(frame))
  }

  public func xInFrame(_ frame: CGRect) -> CGFloat {
    let margin = frame.width * left

    return frame.minX + margin
  }

  public func yInFrame(_ frame: CGRect) -> CGFloat {
    let margin = frame.height * top

    return frame.minY + margin
  }

  public func isEqualTo(position: Position, epsilon: CGFloat = 0.0001) -> Bool {
    let dx = left - position.left, dy = top - position.top

    return (dx * dx + dy * dy) < epsilon
  }
}
