import Quick
import Nimble
import Presentation

class DissolveAnimationSpec: QuickSpec {

  override func spec() {
    describe("DissolveAnimation") {
      var animation: DissolveAnimation!
      var view: UIView!
      var content: Content!
      var superview: UIView!

      beforeEach {
        view = SpecHelper.imageView()
        content = Content(view: view, position: Position(left: 0.2, bottom: 0.2))
        superview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 200.0))
        animation = DissolveAnimation(content: content, duration: 0.0, delay: 0.0)
      }

      describe("#init") {
        it("sets alpha to zero") {
          expect(Double(view.alpha)) ≈ Double(0.0)
        }
      }

      describe("#play") {
        beforeEach {
          superview.addSubview(view)
          animation.play()
        }

        it("changes alpha to 1.0") {
          expect(Double(view.alpha)) ≈ Double(1.0)
        }
      }

      describe("#playBack") {
        beforeEach {
          superview.addSubview(view)
          animation.playBack()
        }

        it("changes alpha to zero") {
          expect(Double(view.alpha)) ≈ Double(0.0)
        }
      }

      describe("#moveWith") {
        context("with superview") {
          beforeEach {
            superview.addSubview(view)
          }

          context("with positive offsetRatio") {
            it("changes alpha correctly") {
              let offsetRatio: CGFloat = 0.4

              animation.moveWith(offsetRatio)
              expect(Double(view.alpha)) ≈ Double(0.4)
            }
          }

          context("with negative offsetRatio") {
            it("changes alpha correctly") {
              let offsetRatio: CGFloat = -0.4

              animation.moveWith(offsetRatio)
              expect(Double(view.alpha)) ≈ Double(0.6)
            }
          }
        }

        context("without superview") {
          it("doesn't change alpha") {
            let offsetRatio: CGFloat = 0.4

            animation.moveWith(offsetRatio)
            expect(Double(view.alpha)) ≈ Double(0.0)
          }
        }
      }
    }
  }
}
