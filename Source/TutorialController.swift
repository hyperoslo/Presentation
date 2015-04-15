import UIKit
import Pages
import Hex

let MinimumMarginLateralSpace: CGFloat = 20.0

@objc public class TutorialController: PagesController {

  convenience init(pages: [UIViewController]) {
    self.init(transitionStyle: .Scroll,
      navigationOrientation: .Horizontal,
      options: nil)
    self.add(pages)
  }

  override public func add(viewControllers: [UIViewController]) {
    super.add(viewControllers)
  }

  override public func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    NSNotificationCenter.defaultCenter().addObserver(self,
      selector: "didRotate",
      name: UIDeviceOrientationDidChangeNotification,
      object: nil)
  }

  override public func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)

    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
  }

  // MARK: UIAppearance

  static func setFont(font: UIFont) {
    UILabel.appearance().font = font
  }

  static func setColor(color: UIColor) {
    UILabel.appearance().textColor = color
  }

  // MARK: Device orientation

  func didRotate() {
    layoutSubviews()
  }

}
