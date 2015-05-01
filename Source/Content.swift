import UIKit
import Cartography

public class Content: NSObject {

  public var view: UIView
  public private(set) var initialPosition: Position
  public var centered: Bool = true

  let group = ConstraintGroup()

  public var position: Position {
    didSet {
      layout()
    }
  }

  public init(view: UIView, position: Position, centered: Bool = true) {
    self.view = view
    self.view.setTranslatesAutoresizingMaskIntoConstraints(true)

    self.position = position
    self.centered = centered

    initialPosition = position.positionCopy

    super.init()
  }

  public func layout() {
    if let superview = view.superview {
      view.placeAtPosition(position)
      if centered {
        view.alignToCenter()
      }
    }
  }
}

extension Content {

  public class func titleContent(text: String,
    attributes: [NSObject: AnyObject]? = nil) -> Content {
      let label = UILabel(frame: CGRectZero)
      label.numberOfLines = 1
      label.attributedText = NSAttributedString(string: text, attributes: attributes)
      label.sizeToFit()

      let position = Position(left: 0.9, bottom: 0.25)

      return Content(view: label, position: position)
  }

  public class func textContent(text: String,
    attributes: [NSObject: AnyObject]? = nil) -> Content {
      let textView = UITextView(frame: CGRectZero)
      textView.backgroundColor = .clearColor()
      textView.attributedText = NSAttributedString(string: text, attributes: attributes)
      textView.sizeToFit()

      return Content(view: textView, position: Position(left: 0.9, bottom: 0.15))
  }

  public class func imageContent(image: UIImage) -> Content {
    let imageView = UIImageView(image: image)

    return Content(view: imageView, position: Position(left: 0.5, bottom: 0.5))
  }
}
