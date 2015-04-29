import Quick
import Nimble
import Tutorial

class CGRectExtensionSpec: QuickSpec {

  override func spec() {
    describe("CGRectExtension") {
      var rect: CGRect!

      beforeEach {
        rect = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 80.0)
      }

      describe("#rotatedRect") {
        it ("returns correct rect") {
          var rotatedRect = rect.rotatedRect

          expect(Double(CGRectGetMinX(rotatedRect))) ≈ Double(CGRectGetMinX(rect))
          expect(Double(CGRectGetMinY(rotatedRect))) ≈ Double(CGRectGetMinY(rect))
          expect(Double(CGRectGetHeight(rotatedRect))) ≈ Double(CGRectGetWidth(rect))
          expect(Double(CGRectGetWidth(rotatedRect))) ≈ Double(CGRectGetHeight(rect))
        }
      }
    }
  }
}
