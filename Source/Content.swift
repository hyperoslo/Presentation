import UIKit

public final class Content: NSObject {
  public var view: UIView
  public var centered: Bool

  public var position: Position {
    didSet {
      layout()
    }
  }

  public private(set) var initialPosition: Position
  private var constraints = [NSLayoutConstraint]()

  public init(view: UIView, position: Position, centered: Bool = true) {
    self.view = view
    self.position = position
    self.centered = centered
    initialPosition = position.positionCopy

    super.init()

    view.translatesAutoresizingMaskIntoConstraints = false
    setupSizeConstraints()
  }

  public func layout() {
    guard let superview = view.superview else {
      return
    }

    NSLayoutConstraint.deactivate(constraints)

    let xAttribute: NSLayoutAttribute = centered ? .centerX : .leading
    let yAttribute: NSLayoutAttribute = centered ? .centerY : .top
    let xSuperAttribute: NSLayoutAttribute = position.left == 0 ? .leading : .trailing
    let ySuperAttribute: NSLayoutAttribute = position.top == 0 ? .top : .bottom
    let xMultiplier: CGFloat = position.left == 0 ? 1 : position.left
    let yMultiplier: CGFloat = position.top == 0 ? 1 : position.top

    constraints = [
      NSLayoutConstraint(
        item: view,
        attribute: xAttribute,
        relatedBy: .equal,
        toItem: superview,
        attribute: xSuperAttribute,
        multiplier: xMultiplier,
        constant: 0
      ),
      NSLayoutConstraint(
        item: view,
        attribute: yAttribute,
        relatedBy: .equal,
        toItem: superview,
        attribute: ySuperAttribute,
        multiplier: yMultiplier,
        constant: 0
      )
    ]

    NSLayoutConstraint.activate(constraints)
    view.layoutIfNeeded()
  }

  public func animate() {
    view.superview!.layoutIfNeeded()
  }

  private func setupSizeConstraints() {
    makeSizeConstraint(attribute: .width, constant: view.frame.width).isActive = true
    makeSizeConstraint(attribute: .height, constant: view.frame.height).isActive = true
  }

  private func makeSizeConstraint(attribute: NSLayoutAttribute,
                                  constant: CGFloat) -> NSLayoutConstraint {
    return NSLayoutConstraint(
      item: view,
      attribute: attribute,
      relatedBy: .equal,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1,
      constant: constant
    )
  }
}

public extension Content {
  class func content(forTitle text: String, attributes: [NSAttributedStringKey: Any]? = nil) -> Content {
    let label = UILabel(frame: CGRect.zero)
    label.numberOfLines = 1
    label.attributedText = NSAttributedString(string: text, attributes: attributes)
    label.sizeToFit()

    let position = Position(left: 0.9, bottom: 0.2)

    return Content(view: label, position: position)
  }

  class func content(forText text: String, attributes: [NSAttributedStringKey: Any]? = nil) -> Content {
    let textView = UITextView(frame: CGRect.zero)
    textView.backgroundColor = UIColor.clear
    textView.attributedText = NSAttributedString(string: text, attributes: attributes)
    textView.sizeToFit()

    return Content(view: textView, position: Position(left: 0.9, bottom: 0.1))
  }

  class func content(forImage image: UIImage) -> Content {
    let imageView = UIImageView(image: image)
    return Content(view: imageView, position: Position(left: 0.5, bottom: 0.5))
  }

  class func centerTransition(forSlideContent content: Content) -> Animatable {
    return TransitionAnimation(
      content: content,
      destination: Position(left: 0.5, bottom: content.initialPosition.bottom),
      duration: 2.0,
      damping: 0.8,
      reflective: true
    )
  }
}
