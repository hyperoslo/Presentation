import UIKit

@objc public class BackViewModel: NSObject {

  public var view: UIView
  public var position: TutorialViewPosition

  init(view: UIView, position: TutorialViewPosition) {
    self.view = view
    self.position = position

    super.init()
  }

  public func place() {
    view.placeAtPosition(position)
  }

  public func rotate() {
    view.rotateAtPosition(position)
  }
}
