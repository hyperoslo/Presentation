import UIKit
import Pages

public class TutorialController: Pages {

  public var titleFont: UIFont?

  var titleLabel: UILabel {
    let bounds = UIScreen.mainScreen().bounds
    var frame = bounds
    frame.size.width = bounds.width
    frame.size.height = bounds.height / 2
    frame.origin.x = 0.0
    frame.origin.y = 0.0
    let label = UILabel(frame: frame)

    if self.titleFont != nil {
      label.font = self.titleFont
    } else {
      label.font = UIFont(name: "DINAlternate-Bold", size: 48.0)
    }

    label.numberOfLines = 4
    label.textAlignment = .Center

    return label
    }

  convenience init(pages: [UIViewController]) {
    self.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    self.addPages(pages)
  }

  override public func addPage(viewController: UIViewController) {
    let titleLabel = self.titleLabel
    titleLabel.text = viewController.title!
    viewController.view.addSubview(titleLabel)
    super.addPage(viewController)
  }

  override public func addPages(viewControllers: [UIViewController]) {
    for viewController: UIViewController in viewControllers {
      self.addPage(viewController)
    }
  }

}
