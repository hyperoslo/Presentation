import UIKit

@objc public class Position {

    public var left: CGFloat
    public var top: CGFloat

    init(left: CGFloat, top: CGFloat) {
        self.left = left
        self.top = top
    }

    public func originInFrame(frame: CGRect) -> CGPoint {
        return CGPoint(x: xInFrame(frame), y: yInFrame(frame))
    }

    public func xInFrame(frame: CGRect) -> CGFloat {
        let margin = CGRectGetWidth(frame) * left

        return CGRectGetMinX(frame) + margin
    }

    public func yInFrame(frame: CGRect) -> CGFloat {
        let margin = CGRectGetHeight(frame) * top

        return CGRectGetMinY(frame) + margin
    }
}
