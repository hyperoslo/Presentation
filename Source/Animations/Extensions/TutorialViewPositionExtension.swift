import UIKit

extension TutorialViewPosition {

  func originInFrame(frame: CGRect) -> CGPoint {
    return CGPoint(x: xInFrame(frame), y: yInFrame(frame))
  }

  func xInFrame(frame: CGRect) -> CGFloat {
    var x: CGFloat = 0.0
    let margin = CGRectGetWidth(frame) * xPercentage

    switch hMargin {
    case HorizontalMarginType.Left:
      x = CGRectGetMinX(frame) + margin
    case HorizontalMarginType.Right:
      x = CGRectGetMaxX(frame) - margin
    }

    return x
  }

  func yInFrame(frame: CGRect) -> CGFloat {
    var y: CGFloat = 0.0
    let margin = CGRectGetHeight(frame) * yPercentage

    switch vMargin {
    case VerticalMarginType.Top:
      y = CGRectGetMinY(frame) + margin
    case VerticalMarginType.Bottom:
      y = CGRectGetMaxY(frame) - margin
    }

    return y
  }
}
