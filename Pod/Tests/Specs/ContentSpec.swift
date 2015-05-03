import Quick
import Nimble
import UIKit
import Presentation

class ContentSpec: QuickSpec {

  override func spec() {
    describe("Content") {
      var content: Content!
      var position: Position!
      var superview: UIView!

      beforeEach {
        position = Position(left: 0.5, top: 0.5)
        content = Content(view: SpecHelper.imageView(), position: position)
        superview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 200.0))
      }

      describe("#layout") {
        context("with superview") {
          beforeEach {
            superview.addSubview(content.view)
          }

          it("changes center correctly") {
            let center = position.originInFrame(superview.bounds)

            content.layout()
            expect(content.view.center).to(equal(center))
          }

          it("changes origin correctly") {
            content.centered = false
            let origin = position.originInFrame(superview.bounds)

            content.layout()
            expect(content.view.frame.origin).to(equal(origin))
          }
        }

        context("without superview") {
          it("doesn't change origin") {
            let origin = content.view.frame.origin

            content.layout()
            expect(content.view.frame.origin).to(equal(origin))
          }
        }
      }
    }
  }
}
