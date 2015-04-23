import UIKit
import Pages
import Hex

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

  // MARK: UIAppearance

  public static func setTitleFont(font: UIFont) {
    UILabel.appearance().font = font
  }

  public static func setTextFont(font: UIFont) {
    UITextView.appearance().font = font
  }

  public static func setTitleColor(color: UIColor) {
    UILabel.appearance().textColor = color
  }

  public static func setTextColor(color: UIColor) {
    UITextView.appearance().textColor = color
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
