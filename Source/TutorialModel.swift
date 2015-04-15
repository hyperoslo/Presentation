import UIKit

@objc public class TutorialModel: NSObject {

  // MARK: Public methods

  public var image: UIImage? {
    get {
      return imageView.image
    }
    set(newImage) {
      imageView.image = newImage
    }
  }

  public var title: String? {
    get {
      return titleLabel.text
    }
    set(newValue) {
      titleLabel.text = newValue
    }
  }
  public var text: String? {
    get {
      return textLabel.text
    }
    set(newText) {
      textLabel.text = newText
    }
  }

  lazy private(set) var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.autoresizingMask = .FlexibleLeftMargin | .FlexibleRightMargin

    return imageView
    }()

  lazy private(set) var titleLabel: UILabel = {
    let label = UILabel(frame: CGRectNull)

    label.autoresizingMask = .FlexibleLeftMargin | .FlexibleRightMargin
    label.font = UIFont(name: "DIN Alternate", size: 48.0)
    label.numberOfLines = 1
    label.textAlignment = .Center
    label.textColor = UIColor(fromHex: "234583")

    return label
    }()

  lazy private(set) var textLabel: UILabel = {
    let label = UILabel(frame: CGRectNull)

    label.autoresizingMask = .FlexibleLeftMargin | .FlexibleRightMargin
    label.font = UIFont(name: "DIN Alternate", size: 32.0)
    label.numberOfLines = 4
    label.textAlignment = .Center
    label.textColor = UIColor(fromHex: "234583")

    return label
    }()

  convenience init(title: String?, text: String?, image: UIImage?) {
    self.init()

    self.image = image
    self.title = title
    self.text = text
  }

}

extension TutorialModel {
  func views() -> [AnyObject] {
    var views: [AnyObject] = []

    if image != nil {
      views.append(imageView)
    }

    if title != nil {
      views.append(titleLabel)
    }

    if text != nil {
      views.append(textLabel)
    }

    return views
  }
}

extension UIViewController {

  convenience init(model: TutorialModel) {
    self.init(nibName: nil, bundle: nil)
    addModel(model)
  }

  func addModel(model: TutorialModel) {
    for modelView in model.views() {
      self.view.addSubview(modelView as! UIView)
    }
    layoutSubviews()
  }

  func layoutSubviews() {
    let bounds = UIScreen.mainScreen().bounds
    var y: CGFloat = 0.0

    for object in self.view.subviews {
      var view = object as! UIView
      var frame = bounds

      if object.isKindOfClass(UIImageView.classForCoder()) {
        let imageSize = (object as! UIImageView).image!.size

        frame.size.width = imageSize.width
        frame.size.height = imageSize.height
        frame.origin.x = bounds.size.width / 2 - imageSize.width / 2
        frame.origin.y = bounds.size.height / 2 - imageSize.height / 2
        y = frame.origin.y + frame.height
      } else {
        frame.size.width = bounds.width - MinimumMarginLateralSpace * 2
        frame.size.height = bounds.height / 2 / 4
        frame.origin.x = bounds.size.width / 2 - frame.size.width / 2

        if y == 0.0 {
          y = bounds.height / 2 - frame.size.height / 2
        }

        frame.origin.y = y
        y += frame.size.height
      }

      view.frame = frame
    }
  }

}
