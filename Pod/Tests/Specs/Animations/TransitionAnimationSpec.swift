import Quick
import Nimble
import Presentation

class TransitionAnimationSpec: QuickSpec {

  override func spec() {
    describe("TransitionAnimation") {
      var animation: TransitionAnimation!
      var view: UIView!
      var content: Content!
      var destination: Position!
      var superview: UIView!

      beforeEach {
        view = SpecHelper.imageView()
        content = Content(view: view, position: Position(left: 0.3, top: 0.5))
        destination = Position(left: 0.5, top: 0.5)
        superview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 200.0))
        animation = TransitionAnimation(content: content, destination: destination, duration: 0)
      }

      describe("#play") {
        context("with superview") {
          beforeEach {
            superview.addSubview(view)
            content.layout()
          }

          it("moves view to the destination point") {
            let center = destination.originInFrame(superview.bounds)

            animation.play()
            expect(view.center).to(equal(center))
          }
        }

        context("without superview") {
          it("doesn't change position") {
            let center = view.center

            animation.play()
            expect(view.center).to(equal(center))
          }
        }
      }

      describe("#playBack") {
        var center = CGPointZero

        context("with superview") {
          beforeEach {
            superview.addSubview(view)
            content.layout()
            center = view.center
            animation.play()
          }

          it("moves view to the destination point") {
            animation.playBack()
            expect(view.center).to(equal(center))
          }
        }

        context("without superview") {
          var center = CGPointZero

          beforeEach {
            superview.addSubview(view)
            content.layout()
            animation.play()
            center = view.center

            view.removeFromSuperview()
          }

          it("doesn't change position") {
            animation.playBack()
            expect(view.center).to(equal(center))
          }
        }
      }

      describe("#moveWith") {
        var center = CGPointZero

        beforeEach {
          center = view.center
        }

        context("with superview") {
          var startX: CGFloat = 0.0
          var dx: CGFloat = 0.0

          beforeEach {
            superview.addSubview(view)
            content.layout()
            center = view.center

            let start = view.center.positionInFrame(superview.bounds)
            startX = start.xInFrame(superview.bounds)
            dx = destination.xInFrame(superview.bounds) - startX
          }

          context("with positive offsetRatio") {
            it("moves view correctly") {
              let offsetRatio: CGFloat = 0.4
              let offset = dx * offsetRatio
              center.x = startX + offset

              animation.moveWith(offsetRatio)
              expect(view.center).to(equal(center))
            }
          }

          context("with negative offsetRatio") {
            it("moves view correctly") {
              let offsetRatio: CGFloat = -0.4
              let offset = dx * (1.0 + offsetRatio)
              center.x = startX + offset

              animation.moveWith(offsetRatio)
              expect(view.center).to(equal(center))
            }
          }
        }

        context("without superview") {
          it("doesn't change position") {
            let offsetRatio: CGFloat = -0.4

            animation.moveWith(offsetRatio)
            expect(view.center).to(equal(center))
          }
        }

        context("with playing animations") {
          beforeEach {
            superview.addSubview(view)
            content.layout()
            center = view.center

            UIView.animateWithDuration(2.0, animations: {
              view.alpha = 0.5
            })
          }

          it("doesn't change position") {
            let offsetRatio: CGFloat = -0.4

            animation.moveWith(offsetRatio)
            expect(view.center).to(equal(center))
          }
        }
      }
    }
  }
}
