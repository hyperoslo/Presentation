import UIKit
import Pages

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

  @objc public static func setTitleFont(font: UIFont) {
    UILabel.appearance().font = font
  }

  @objc public static func setTextFont(font: UIFont) {
    UITextView.appearance().font = font
  }

  @objc public static func setTitleColor(color: UIColor) {
    UILabel.appearance().textColor = color
  }

  @objc public static func setTextColor(color: UIColor) {
    UITextView.appearance().textColor = color
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

    model.layoutSubviews()
  }
}
