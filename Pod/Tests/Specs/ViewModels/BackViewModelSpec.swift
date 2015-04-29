import Quick
import Nimble
import UIKit
import Tutorial

class BackViewModelSpec: QuickSpec {

  override func spec() {
    describe("BackViewModel") {
      var model: BackViewModel!
      var position: Position!
      var superview: UIView!

      beforeEach {
        position = Position(left: 0.2, top: 0.2)
        model = BackViewModel(view: SpecHelper.imageView(), position: position)
        superview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 200.0))
      }

      describe("#place") {
        context("with superview") {
          beforeEach {
            superview.addSubview(model.view)
          }

          it("changes origin correctly") {
            let origin = position.originInFrame(superview.bounds)

            model.place()
            expect(model.view.frame.origin).to(equal(origin))
          }
        }

        context("without superview") {
          it("doesn't change origin") {
            let origin = model.view.frame.origin

            model.place()
            expect(model.view.frame.origin).to(equal(origin))
          }
        }
      }

      describe("#rotate") {
        it("changes view position correctly") {
          superview.addSubview(model.view)
          var rotatedFrame = superview.bounds.rotatedRect
          let origin = position.originInFrame(rotatedFrame)

          model.rotate()
          expect(model.view.frame.origin).to(equal(origin))
        }
      }
    }
  }
}
