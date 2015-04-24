import UIKit
import Cartography

@objc public class TutorialModel: NSObject {

  struct Dimensions {
    static let minimumMarginSpace: CGFloat = 20.0
  }

  // MARK: Public properties

  public var image: UIImage? {
    get {
      return imageView.image
    }
    set {
      imageView.image = newValue
    }
  }

  public var title: String? {
    get {
      return titleLabel.text
    }
    set {
      titleLabel.text = newValue
    }
  }
  public var text: String? {
    get {
      return textView.text.isEmpty ? nil : textView.text
    }
    set {
      textView.text = newValue
    }
  }

  lazy private(set) var imageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
    }()

  lazy private(set) var titleLabel: UILabel = {
    let label = UILabel(frame: CGRectNull)

    label.numberOfLines = 1
    label.textAlignment = .Center

    return label
    }()

  lazy private(set) var textView: UITextView = {
    let textView = UITextView(frame: CGRectNull)

    textView.textAlignment = .Center
    textView.backgroundColor = UIColor.clearColor()

    return textView
    }()

  convenience init(title: String?, text: String?, image: UIImage?) {
    self.init()

    self.image = image
    self.title = title
    self.text = text
  }
}

// MARK: Styling

extension TutorialModel {

  public func setTitleAttributes(attributes: [String: AnyObject]) {
    if let text = titleLabel.text {
      titleLabel.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
  }

  public func setTextAttributes(attributes: [String: AnyObject]) {
    let text = textView.text
    textView.attributedText = NSAttributedString(string: text, attributes: attributes)
  }
}

// MARK: Views

extension TutorialModel {

  func views() -> [UIView] {
    var views = [UIView]()

    if image != nil {
      views.append(imageView)
    }

    if title != nil {
      views.append(titleLabel)
    }

    if text != nil {
      views.append(textView)
    }

    return views
  }
}

// MARK: Layout

extension TutorialModel {

  func layoutSubviews() {
    layout(textView, titleLabel, imageView) {
      [unowned self]textView, titleLabel, imageView in

      var hasTextView = false
      if let superview = textView.superview {
        textView.width == superview.width - Dimensions.minimumMarginSpace * 2
        textView.height >= superview.height / 4
        textView.bottom == superview.bottom - Dimensions.minimumMarginSpace
        textView.centerX == superview.centerX

        hasTextView = true
      }

      if let superview = titleLabel.superview {
        titleLabel.width == superview.width - Dimensions.minimumMarginSpace * 2
        let bottom = hasTextView ? textView.top : superview.bottom
        titleLabel.bottom == bottom - Dimensions.minimumMarginSpace
        titleLabel.centerX == superview.centerX
      }

      if let superview = imageView.superview {
        let size = self.imageView.image!.size
        imageView.width == size.width
        imageView.height == size.height
        imageView.centerX == superview.centerX
        imageView.centerY == superview.centerY
      }
    }
  }
}
