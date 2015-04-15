import UIKit
import Pages
import Hex

let MinimumMarginLateralSpace: CGFloat = 20.0

@objc public class TutorialController: PagesController {

  public var titleFont: UIFont?
  public var titleColor: UIColor?

  var titleLabel: UILabel {
    let bounds = UIScreen.mainScreen().bounds
    var frame = bounds
    frame.size.width = bounds.width - MinimumMarginLateralSpace * 2
    frame.size.height = bounds.height / 2
    frame.origin.x = 0.0 + MinimumMarginLateralSpace
    frame.origin.y = 0.0 + navigationController!.navigationBar.frame.height
    let label = UILabel(frame: frame)

    label.font = titleFont != nil ? titleFont : UIFont(name: "DIN Alternate", size: 48.0)
    label.textColor = titleColor != nil ? titleColor : UIColor(fromHex: "234583")

    label.numberOfLines = 4
    label.textAlignment = .Center
    label.autoresizingMask = .FlexibleLeftMargin | .FlexibleRightMargin

    return label
    }

  convenience init(pages: [UIViewController]) {
    self.init(transitionStyle: .Scroll,
      navigationOrientation: .Horizontal,
      options: nil)
    self.add(pages)
  }

  override public func add(viewControllers: [UIViewController]) {
    for viewController: UIViewController in viewControllers {
      let titleLabel = self.titleLabel
      titleLabel.text = viewController.title
      viewController.view.addSubview(titleLabel)
    }

    super.add(viewControllers)
  }

}
