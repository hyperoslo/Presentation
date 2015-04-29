import Quick
import Nimble
import Tutorial

class TransitionAnimationSpec: QuickSpec {

  override func spec() {
    describe("TransitionAnimation") {
      var animation: TransitionAnimation!
      var view: UIView!
      var destination: Position!
      var superview: UIView!

      beforeEach {
        view = SpecHelper.imageView()
        destination = Position(left: 0.2, top: 0.1)
        superview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 200.0))
        animation = TransitionAnimation(view: view, destination: destination, duration: 0)
      }

      describe("#play") {
        context("with superview") {
          beforeEach {
            superview.addSubview(view)
          }

          it("moves view to the destination point") {
            var frame = view.frame
            frame.origin = destination.originInFrame(superview.bounds)

            animation.play()
            expect(view.frame).to(equal(frame))
          }
        }

        context("without superview") {
          it("doesn't change position") {
            let origin = view.frame.origin

            animation.play()
            expect(view.frame.origin).to(equal(origin))
          }
        }
      }

      describe("#playBack") {
        var frame = CGRectZero

        context("with superview") {
          beforeEach {
            superview.addSubview(view)
            frame = view.frame
            animation.play()
          }

          it("moves view to the destination point") {
            animation.playBack()
            expect(view.frame).to(equal(frame))
          }
        }

        context("without superview") {
          var origin = CGPointZero

          beforeEach {
            superview.addSubview(view)
            animation.play()
            origin = view.frame.origin

            view.removeFromSuperview()
          }

          it("doesn't change position") {
            animation.playBack()
            expect(view.frame.origin).to(equal(origin))
          }
        }
      }

      describe("#move") {
        var frame = CGRectZero

        beforeEach {
          frame = view.frame
        }

        context("with superview") {
          var startX: CGFloat = 0.0
          var dx: CGFloat = 0.0

          beforeEach {
            superview.addSubview(view)

            let start = view.frame.origin.positionInFrame(superview.bounds)
            startX = start.xInFrame(superview.bounds)
            dx = destination.xInFrame(superview.bounds) - startX
          }

          context("with positive offsetRatio") {
            it("moves view correctly") {
              let offsetRatio: CGFloat = 0.4
              let offset = dx * offsetRatio
              frame.origin.x = startX + offset

              animation.move(offsetRatio)
              expect(view.frame).to(equal(frame))
            }
          }

          context("with negative offsetRatio") {
            it("moves view correctly") {
              let offsetRatio: CGFloat = -0.4
              let offset = dx * (1.0 + offsetRatio)
              frame.origin.x = startX + offset

              animation.move(offsetRatio)
              expect(view.frame).to(equal(frame))
            }
          }
        }

        context("without superview") {
          it("doesn't change position") {
            let offsetRatio: CGFloat = -0.4

            animation.move(offsetRatio)
            expect(view.frame).to(equal(frame))
          }
        }

        context("with playing animations") {
          beforeEach {
            superview.addSubview(view)
            UIView.animateWithDuration(2.0, animations: {
              view.alpha = 0.5
            })
          }

          it("doesn't change position") {
            let offsetRatio: CGFloat = -0.4

            animation.move(offsetRatio)
            expect(view.frame).to(equal(frame))
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
