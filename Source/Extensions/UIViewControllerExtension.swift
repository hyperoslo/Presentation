import UIKit

public extension UIViewController {

  convenience init(model: ContentViewModel) {
    self.init(nibName: nil, bundle: nil)

    addViewsFromModel(model)
  }

  func addViewsFromModel(model: ContentViewModel) {
    let modelViews = model.views()

    for modelView in modelViews {
      view.addSubview(modelView)
    }

    model.layoutSubviews()
  }
}
