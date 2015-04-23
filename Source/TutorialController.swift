import UIKit
import Pages
import Hex

private let MinimumMarginLateralSpace: CGFloat = 20.0

public class TutorialController: PagesController {

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


  public static func setFont(font: UIFont) {
    UILabel.appearance().font = font
  }

  public static func setTextColor(color: UIColor) {
    UILabel.appearance().textColor = color
  }

  // MARK: Device orientation

  func didRotate() {
    layoutSubviews()
  }

}

public extension UIViewController {

  convenience init(model: TutorialModel) {
    self.init(nibName: nil, bundle: nil)

    addModel(model)
  }

  public func addModel(model: TutorialModel) {
    for modelView in model.views() {
      view.addSubview(modelView)
    }

    layoutSubviews()
  }

  func layoutSubviews() {
    let bounds = UIScreen.mainScreen().bounds
    var y: CGFloat = 0.0

    for object in view.subviews {
      var view = object as! UIView
      var frame = bounds

      if let object = object as? UIImageView {
        let imageSize = object.image!.size

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
