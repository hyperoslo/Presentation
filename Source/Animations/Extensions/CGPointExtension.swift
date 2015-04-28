import UIKit

extension CGPoint {

  func positionInFrame(frame: CGRect) -> TutorialViewPosition {
    var xPercentage = x / CGRectGetWidth(frame)
    var yPercentage = y / CGRectGetHeight(frame)

    var hMargin: HorizontalMarginType = .Left
    var vMargin: VerticalMarginType = .Top

    if xPercentage > 0.5 {
      xPercentage = 1.0 - xPercentage
      hMargin = .Right
    }

    if yPercentage > 0.5 {
      yPercentage = 1.0 - yPercentage
      vMargin = .Bottom
    }

    return TutorialViewPosition(xPercentage: xPercentage,
      yPercentage: yPercentage, hMargin: hMargin, vMargin: vMargin)
  }
}
