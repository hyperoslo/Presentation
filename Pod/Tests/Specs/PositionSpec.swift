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
        it("sets title to titleLabel") {

        }

        it("sets text to textView") {

        }

        it("sets image to imageView") {
          
        }
      }

    }
  }
}
