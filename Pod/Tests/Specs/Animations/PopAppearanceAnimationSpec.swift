import Quick
import Nimble
import Tutorial

class PopAppearanceAnimationSpec: QuickSpec {

  override func spec() {
    describe("PopAppearanceAnimation") {
      var animation: PopAppearanceAnimation!
      var view: UIView!
      var destination: Position!
      var superview: UIView!

      beforeEach {
        view = SpecHelper.imageView()
        destination = Position(left: 0.2, top: 0.1)
        superview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 200.0))
        animation = PopAppearanceAnimation(view: view, destination: destination, duration: 0)
      }

      describe("#init") {
        it("hides view") {
          expect(view.hidden).to(beTrue())
        }
      }

      describe("#move") {
        context("with superview") {
          beforeEach {
            superview.addSubview(view)
          }

          context("with positive offsetRatio") {
            it("moves view correctly") {
              let offsetRatio: CGFloat = 0.4

              animation.move(offsetRatio)
              expect(Double(view.alpha)) ≈ Double(0.4)
            }
          }

          context("with negative offsetRatio") {
            it("moves view correctly") {
              let offsetRatio: CGFloat = -0.4

              animation.move(offsetRatio)
              expect(Double(view.alpha)) ≈ Double(0.6)
            }
          }
        }

        context("without superview") {
          it("doesn't change position") {
            let offsetRatio: CGFloat = 0.4

            animation.move(offsetRatio)
            expect(Double(view.alpha)) ≈ Double(1.0)
          }
        }

        context("with playing animations") {
          beforeEach {
            superview.addSubview(view)
            UIView.animateWithDuration(2.0, animations: {
              view.frame = CGRectZero
            })
          }

          it("doesn't change position") {
            let offsetRatio: CGFloat = -0.4

            animation.move(offsetRatio)
            expect(Double(view.alpha)) ≈ Double(1.0)
          }
        }
      }

      describe("#rotate") {
        it("changes view position correctly") {
          superview.addSubview(view)
          var rotatedFrame = superview.bounds.rotatedRect
          let origin = destination.originInFrame(rotatedFrame)

          animation.rotate()
          expect(view.frame.origin).to(equal(origin))
        }
      }
    }
  }
}
