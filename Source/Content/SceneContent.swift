import UIKit

public class SceneContent: Content {

  public var animations = [Animation?]()

  public convenience init(view: UIView, position: Position, animations: [Animation]) {
    self.init(view: view, position: position)

    for index in 0...animations.count - 1 {
      self.animations.append(animations[index])
      self.animations[index]!.content = self
    }
  }

  deinit {
    for index in 0...animations.count - 1 {
      animations[index] = nil
    }
  }
}
