import UIKit

@objc public class SceneContent: Content {

  public var animations = [Animation]()

  public convenience init(view: UIView, position: Position, animations: [Animation]) {
    self.init(view: view, position: position)

    self.animations = animations
  }
}
