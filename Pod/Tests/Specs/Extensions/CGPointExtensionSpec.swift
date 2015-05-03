import Quick
import Nimble
import Presentation

class CGPointExtensionSpec: QuickSpec {

  override func spec() {
    describe("CGPointExtension") {
      var point: CGPoint!
      let frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 80.0)

      beforeEach {
        point = CGPoint(x: 100.0, y: 80.0)
      }

      describe("#positionInFrame") {
        it ("returns correct position") {
          var left = point.x / CGRectGetWidth(frame)
          var top = point.y / CGRectGetHeight(frame)
          let position = point.positionInFrame(frame)

          expect(Double(position.left)) ≈ Double(left)
          expect(Double(position.top)) ≈ Double(top)
        }
      }
    }
  }
}
