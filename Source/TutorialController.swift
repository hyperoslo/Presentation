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

  // MARK: UIAppearance

  static func setFont(font: UIFont) {
    UILabel.appearance().font = font
  }

  static func setColor(color: UIColor) {
    UILabel.appearance().textColor = color
  }

}
