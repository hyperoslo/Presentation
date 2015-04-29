import Quick
import Nimble
import Tutorial

class UIViewExtensionSpec: QuickSpec {

  override func spec() {
    describe("UIViewExtension") {
      var view: UIView!
      var superview: UIView!
      var position: Position!

      beforeEach {
        view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 80.0))
        superview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 200.0))
        position = Position(left: 0.2, top: 0.2)
      }

      describe("#placeAtPosition") {
        context("with superview") {
          beforeEach {
            superview.addSubview(view)
          }

          it("changes origin correctly") {
            let origin = position.originInFrame(superview.bounds)
            
            view.placeAtPosition(position)
            expect(view.frame.origin).to(equal(origin))
          }
        }

        context("without superview") {
          it("doesn't change origin") {
            let origin = view.frame.origin

            view.placeAtPosition(position)
            expect(view.frame.origin).to(equal(origin))
          }
        }
      }

      describe("#rotateAtPosition") {
        context("with superview") {
          beforeEach {
            superview.addSubview(view)
          }

          it("changes origin correctly") {
            var rotatedFrame = superview.bounds.rotatedRect
            let origin = position.originInFrame(rotatedFrame)

            view.rotateAtPosition(position)
            expect(view.frame.origin).to(equal(origin))
          }
        }

        context("without superview") {
          it("doesn't change origin") {
            let origin = view.frame.origin

            view.rotateAtPosition(position)
            expect(view.frame.origin).to(equal(origin))
          }
        }
      }
    }
  }
}
