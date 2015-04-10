import UIKit
import Pages
import Hex

public class TutorialController: PagesController {

  public var titleFont: UIFont?
  public var titleColor: UIColor?

  var titleLabel: UILabel {
    let bounds = UIScreen.mainScreen().bounds
    var frame = bounds
    frame.size.width = bounds.width
    frame.size.height = bounds.height / 2
    frame.origin.x = 0.0
    frame.origin.y = 0.0
    let label = UILabel(frame: frame)

    label.font = self.titleFont != nil ? self.titleFont : UIFont(name: "DIN Alternate", size: 48.0)
    label.textColor = self.titleColor != nil ? self.titleColor : UIColor(fromHex: "234583")

    label.numberOfLines = 4
    label.textAlignment = .Center
    label.autoresizingMask = .FlexibleLeftMargin | .FlexibleRightMargin

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
