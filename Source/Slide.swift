import UIKit

public class Slide: NSObject {

  public var contents: [Content]
  public var animations: [Animation]

  public init(contents: [Content], animations: [Animation]) {
    self.contents = contents
    self.animations = animations

    super.init()
  }
}
