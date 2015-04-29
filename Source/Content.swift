import UIKit

@objc public class Content: NSObject {

  public var view: UIView
  public var position: Position

  public init(view: UIView, position: Position) {
    self.view = view
    self.position = position

    super.init()
  }

  public func layout() {
    view.placeAtPosition(position)
  }

  public func rotate() {
    view.rotateAtPosition(position)
  }
}
