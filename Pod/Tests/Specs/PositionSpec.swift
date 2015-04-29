import Tutorial
import Quick
import Nimble

class PositionSpec: QuickSpec {

  override func spec() {
    describe("Position") {
      var position: Position!

      beforeEach {
        position = Position(left: 0.2, top: 0.2)
      }

      describe("#init") {
        context("with left and top") {
          beforeEach {
            position = Position(left: 0.2, top: 0.2)
          }

          it("sets position values") {
            expect(position.left).to(equal(0.2))
            expect(position.top).to(equal(0.2))
          }
        }

        context("with left and bottom") {
          beforeEach {
            position = Position(left: 0.2, bottom: 0.2)
          }

          it("sets position values") {
            expect(position.left).to(equal(0.2))
            expect(Double(position.bottom)) ≈ 0.2
          }
        }

        context("with right and top") {
          beforeEach {
            position = Position(right: 0.2, top: 0.2)
          }

          it("sets position values") {
            expect(Double(position.right)) ≈ 0.2
            expect(Double(position.top)) ≈ 0.2
          }
        }

        context("with right and bottom") {
          beforeEach {
            position = Position(right: 0.2, bottom: 0.2)
          }

          it("sets position values") {
            expect(Double(position.right)) ≈ 0.2
            expect(Double(position.bottom)) ≈ 0.2
          }
        }
      }

      describe("#right") {
        it("sets left") {
          position.right = 0.4
          expect(Double(position.left)) ≈ 0.6
        }
      }

      describe("#bottom") {
        it("sets top") {
          position.bottom = 0.4
          expect(Double(position.top)) ≈ 0.6
        }
      }
    }
  }
}
