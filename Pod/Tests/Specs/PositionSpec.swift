import Presentation
import Quick
import Nimble

class PositionSpec: QuickSpec {

  override func spec() {
    describe("Position") {
      var position: Position!
      var frame: CGRect!

      beforeEach {
        position = Position(left: 0.2, top: 0.2)
        frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
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

      describe("#positionCopy") {
        it("returns new instance") {
          let copy = position.positionCopy
          expect(copy).notTo(equal(position))
        }
      }

      describe("#horizontalMirror") {
        it("returns correct position") {
          let mirror = position.horizontalMirror
          expect(mirror.left).to(equal(position.right))
          expect(mirror.top).to(equal(position.left))
        }
      }

      describe("#originInFrame") {
        it("returns correct point") {
          let point = position.originInFrame(frame)
          expect(Double(point.x)) ≈ 20.0
          expect(Double(point.y)) ≈ 20.0
        }
      }

      describe("#xInFrame") {
        it("returns correct x coordinate") {
          let x = position.xInFrame(frame)
          expect(Double(x)) ≈ 20.0
        }
      }

      describe("#yInFrame") {
        it("returns correct y coordinate") {
          let y = position.yInFrame(frame)
          expect(Double(y)) ≈ 20.0
        }
      }

      describe("#isEqualToPosition") {
        it("is equal to position") {
          let somePosition = Position(left: 0.2, top: 0.2)
          expect(position.isEqualToPosition(somePosition)).to(beTrue())
        }

        it("is not equal to position") {
          let somePosition = Position(left: 0.3, top: 0.2)
          expect(position.isEqualToPosition(somePosition)).notTo(beTrue())
        }
      }
    }
  }
}
