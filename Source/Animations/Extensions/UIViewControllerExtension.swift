import UIKit

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
