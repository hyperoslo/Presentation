import UIKit

extension TutorialViewPosition {

  func originInView(view: UIView) -> CGPoint {
    return CGPoint(x: xInView(view), y: yInView(view))
  }

  func xInView(view: UIView) -> CGFloat {
    var x: CGFloat = 0.0
    let margin = CGRectGetWidth(view.frame) * xPercentage

    switch hMargin {
    case HorizontalMarginType.Left:
      x = CGRectGetMinX(view.frame) + margin
    case HorizontalMarginType.Right:
      x = CGRectGetMaxX(view.frame) - margin
    }

    return x
  }

  func yInView(view: UIView) -> CGFloat {
    var y: CGFloat = 0.0
    let margin = CGRectGetHeight(view.frame) * yPercentage

    switch vMargin {
    case VerticalMarginType.Top:
      y = CGRectGetMinY(view.frame) + margin
    case VerticalMarginType.Bottom:
      y = CGRectGetMaxY(view.frame) - margin
    }

    return y
  }
}
