import Quick
import Nimble

class TutorialViewPositionExtensionSpec: QuickSpec {

  override func spec() {
    describe("TutorialViewPositionExtension") {
      let frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 80.0)
      var position: TutorialViewPosition!

      describe("#xInFrame") {
        context("when we have left margin") {
          it("returns correct x coordinate") {
            position = TutorialViewPosition(xPercentage: 0.3, yPercentage: 0.3, hMargin: .Left, vMargin: .Bottom)
            var x: CGRectGetMinX(frame) + CGRectGetWidth(frame) * position.xPercentage

            expect(position.xInFrame(frame)).to(equal(x))
          }
        }
      }
    }
  }
}
