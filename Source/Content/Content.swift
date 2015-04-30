import UIKit

public class Content: NSObject {

  public var view: UIView
  public private(set) var initialPosition: Position
  public var centered: Bool = true

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
    view.placeAtPosition(position)
    if centered {
      view.alignToCenter()
    }
  }

  public func rotate() {
    view.rotateAtPosition(position)
    if centered {
      view.alignToCenter()
    }
  }
}

extension Content {

  public class func titleLabel(text: String, attributes: [NSObject: AnyObject]? = nil) -> UILabel {
    let label = UILabel(frame: CGRectZero)
    label.numberOfLines = 1
    label.attributedText = NSAttributedString(string: text, attributes: attributes)
    label.sizeToFit()

    return label
  }

  public class func textView(text: String, attributes: [NSObject: AnyObject]? = nil) -> UITextView {
    let textView = UITextView(frame: CGRectZero)
    textView.backgroundColor = .clearColor()
    textView.attributedText = NSAttributedString(string: text, attributes: attributes)
    textView.sizeToFit()

    return textView
  }
}
