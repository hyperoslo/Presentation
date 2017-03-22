import UIKit
import Cartography

public final class Content: NSObject {

  public var view: UIView
  public var centered: Bool

  public var position: Position {
    didSet {
      layout()
    }
  }

  public fileprivate(set) var initialPosition: Position
  fileprivate let group = ConstraintGroup()

  public init(view: UIView, position: Position, centered: Bool = true) {
    self.view = view
    self.position = position
    self.centered = centered
    initialPosition = position.positionCopy

    super.init()

    constrain(view) { [unowned self] view in
      view.width  == self.view.frame.width
      view.height == self.view.frame.height
    }
  }

  public func layout() {
    if let _ = view.superview {
      constrain(view, replace: group) { [unowned self] view in
        let x = self.position.left == 0.0 ? view.superview!.left * 1.0 :
          view.superview!.right * self.position.left
        let y = self.position.top == 0.0 ? view.superview!.top * 1.0 :
          view.superview!.bottom * self.position.top
        if self.centered {
          view.centerX == x
          view.centerY  == y
        } else {
          view.left == x
          view.top == y
        }
      }
      view.layoutIfNeeded()
    }
  }

  public func animate() {
    view.superview!.layoutIfNeeded()
  }
}

extension Content {

  public class func content(forTitle text: String,
    attributes: [String : AnyObject]? = nil) -> Content {
      let label = UILabel(frame: CGRect.zero)
      label.numberOfLines = 1
      label.attributedText = NSAttributedString(string: text, attributes: attributes)
      label.sizeToFit()

      let position = Position(left: 0.9, bottom: 0.2)

      return Content(view: label, position: position)
  }

  public class func content(forText text: String,
    attributes: [String : AnyObject]? = nil) -> Content {
      let textView = UITextView(frame: CGRect.zero)
      textView.backgroundColor = UIColor.clear
      textView.attributedText = NSAttributedString(string: text, attributes: attributes)
      textView.sizeToFit()

      return Content(view: textView, position: Position(left: 0.9, bottom: 0.1))
  }

  public class func content(forImage image: UIImage) -> Content {
    let imageView = UIImageView(image: image)

    return Content(view: imageView, position: Position(left: 0.5, bottom: 0.5))
  }

  public class func centerTransition(forSlideContent content: Content) -> Animatable {
    return TransitionAnimation(
      content: content,
      destination: Position(left: 0.5, bottom: content.initialPosition.bottom),
      duration: 2.0,
      damping: 0.8,
      reflective: true)
  }
}
