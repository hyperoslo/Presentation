import UIKit

public class SlideContent: Content {

  public var animation: Animation?

  public convenience init(view: UIView, position: Position, animation: Animation?) {
    self.init(view: view, position: position)

    self.animation = animation
    self.animation?.content = self
  }

  deinit {
    animation = nil
  }
}

extension SlideContent {

  public class func titleContent(text: String,
    attributes: [NSObject: AnyObject]? = nil, animated: Bool = false) -> SlideContent {
      let label = Content.titleLabel(text, attributes: attributes)

      let position = animated ? Position(right: 0.1, top: 0.5) :
        Position(left: 0.5, bottom: 0.5)
      let animation: Animation? = animated ?
        TransitionAnimation(destination: Position(left: 0.5, top: 0.5), duration: 5.0) : nil

      return SlideContent(view: label, position: position, animation: animation)
  }

  public class func textContent(text: String,
    attributes: [NSObject: AnyObject]? = nil, animated: Bool = false) -> SlideContent {
      let textView = Content.textView(text, attributes: attributes)

      return SlideContent(view: textView, position: Position(left: 0.3, bottom: 0.3))
  }

  public class func imageContent(image: UIImage, animated: Bool = false) -> SlideContent {
    let imageView = UIImageView(image: image)

    return SlideContent(view: imageView, position: Position(left: 0.5, bottom: 0.5))
  }
}

