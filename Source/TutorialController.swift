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
