import Quick
import Nimble
import Presentation

class PopAnimationSpec: QuickSpec {

  override func spec() {
    describe("PopAnimation") {
      var animation: PopAnimation!
      var view: UIView!
      var content: Content!
      var superview: UIView!

      beforeEach {
        view = SpecHelper.imageView()
        content = Content(view: view, position: Position(left: 0.2, bottom: 0.2))
        superview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 200.0))
        animation = PopAnimation(content: content, duration: 0)
      }

      describe("#init") {
        it("hides view") {
          expect(view.hidden).to(beTrue())
        }
      }

      describe("#moveWith") {
        context("with superview") {
          beforeEach {
            superview.addSubview(view)
          }

          context("with positive offsetRatio") {
            it("moves view correctly") {
              let offsetRatio: CGFloat = 0.4

              animation.moveWith(offsetRatio)
              expect(Double(view.alpha)) ≈ Double(0.4)
            }
          }

          context("with negative offsetRatio") {
            it("moves view correctly") {
              let offsetRatio: CGFloat = -0.4

              animation.moveWith(offsetRatio)
              expect(Double(view.alpha)) ≈ Double(0.6)
            }
          }
        }

        context("without superview") {
          it("doesn't change position") {
            let offsetRatio: CGFloat = 0.4

            animation.moveWith(offsetRatio)
            expect(Double(view.alpha)) ≈ Double(1.0)
          }
        }
      }
    }
  }
}
