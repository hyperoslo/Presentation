import UIKit
import Pages
import Hex
import Cartography

let MinimumMarginSpace: CGFloat = 20.0

@objc public class TutorialController: PagesController {

  convenience init(pages: [UIViewController]) {
    self.init(
      transitionStyle: .Scroll,
      navigationOrientation: .Horizontal,
      options: nil)

    add(pages)
  }

  override public func add(viewControllers: [UIViewController]) {
    super.add(viewControllers)
  }

  override public func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    NSNotificationCenter.defaultCenter().addObserver(
      self,
      selector: "didRotate",
      name: UIDeviceOrientationDidChangeNotification,
      object: nil)
  }

  override public func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)

    NSNotificationCenter.defaultCenter().removeObserver(
      self,
      name: UIDeviceOrientationDidChangeNotification,
      object: nil)
  }

  // MARK: UIAppearance

  @objc public static func setFont(font: UIFont) {
    UILabel.appearance().font = font
  }

  @objc public static func setTextColor(color: UIColor) {
    UILabel.appearance().textColor = color
  }

  // MARK: Device orientation

  func didRotate() {
    //layoutSubviews()
  }

}

public extension UIViewController {

  convenience init(model: TutorialModel) {
    self.init(nibName: nil, bundle: nil)

    addViewsFromModel(model)
  }

  func addViewsFromModel(model: TutorialModel) {
    let modelViews = model.views()

    for modelView in modelViews {
      view.addSubview(modelView)
    }

    layout(model.textView, model.titleLabel, model.imageView) {
      textView, titleLabel, imageView in

      var hasTextView = false
      if let superview = textView.superview {
        textView.width == superview.width - MinimumMarginSpace * 2
        textView.height >= superview.height / 4
        textView.bottom == superview.bottom + MinimumMarginSpace

        hasTextView = true
      }

      if let superview = titleLabel.superview {
        titleLabel.width == superview.width - MinimumMarginSpace * 2
        let bottom = hasTextView ? textView.top : superview.bottom
        titleLabel.bottom == bottom
      }

      if let superview = imageView.superview {
        let size = model.imageView.image!.size
        imageView.width == size.width
        imageView.height == size.height
        imageView.centerX == superview.centerX
        imageView.centerY == superview.centerY
      }
    }
  }
}
