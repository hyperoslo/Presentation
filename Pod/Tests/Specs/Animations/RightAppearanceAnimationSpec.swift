import Quick
import Nimble
import Tutorial

class RightAppearanceAnimationSpec: QuickSpec {

  struct Dimensions {
    static let defaultOffset: CGFloat = 50.0
  }

  override func spec() {
    describe("RightAppearanceAnimation") {
      var animation: RightAppearanceAnimation!
      var view: UIView!
      var destination: Position!
      var superview: UIView!

      beforeEach {
        view = SpecHelper.imageView()
        destination = Position(left: 0.2, top: 0.1)
        superview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 200.0))
        animation = RightAppearanceAnimation(view: view, destination: destination, duration: 0)
      }

      describe("#placeView") {
        context("with superview") {
          beforeEach {
            superview.addSubview(view)
          }

          it("moves view to the default initial point") {
            var frame = view.frame
            frame.origin.x = CGRectGetMaxX(superview.frame) + Dimensions.defaultOffset
            frame.origin.y = destination.yInFrame(superview.bounds)

            animation.placeView()
            expect(view.frame).to(equal(frame))
          }
        }

        context("without superview") {
          it("doesn't change position") {
            let origin = view.frame.origin

            animation.placeView()
            expect(view.frame.origin).to(equal(origin))
          }
        }
      }
    }
  }
}
