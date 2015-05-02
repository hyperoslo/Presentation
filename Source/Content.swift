import UIKit
import Cartography

public class Content: NSObject {

  public var view: UIView

  public var position: Position {
    didSet {
      layout()
    }
  }

  public private(set) var initialPosition: Position
  private let group = ConstraintGroup()

  public init(view: UIView, position: Position) {
    self.view = view
    self.position = position
    initialPosition = position.positionCopy

    super.init()

    constrain(view) { [unowned self] view in
      view.width  == CGRectGetWidth(self.view.frame)
      view.height == CGRectGetHeight(self.view.frame)
    }
  }

  public func layout() {
    if let superview = view.superview {
      constrain(view, replace: group) { [unowned self] view in
        view.centerY  == view.superview!.bottom * self.position.top
        view.centerX == view.superview!.right * self.position.left
      }
      view.layoutIfNeeded()
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

      let position = Position(left: 0.9, bottom: 0.2)

      return Content(view: label, position: position)
  }

  public class func textContent(text: String,
    attributes: [NSObject: AnyObject]? = nil) -> Content {
      let textView = UITextView(frame: CGRectZero)
      textView.backgroundColor = .clearColor()
      textView.attributedText = NSAttributedString(string: text, attributes: attributes)
      textView.sizeToFit()

      return Content(view: textView, position: Position(left: 0.9, bottom: 0.1))
  }

  public class func imageContent(image: UIImage) -> Content {
    let imageView = UIImageView(image: image)

    return Content(view: imageView, position: Position(left: 0.5, bottom: 0.5))
  }

  public class func centerTransitionForSlideContent(content: Content) -> Animation {
    return TransitionAnimation(
      content: content,
      destination: Position(left: 0.5, bottom: content.initialPosition.bottom),
      duration: 2.0,
      dumping: 0.8,
      reflective: true)
  }
}
