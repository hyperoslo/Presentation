import Quick
import Nimble

class TutorialModelSpec: QuickSpec {

  override func spec() {
    describe("TutorialModel") {
      beforeEach {
      }

      describe("#init") {
        it("sets title to titleLabel") {
          let model = TutorialModel(
            title: "Tutorial on how to make a profit",
            text: nil,
            image: nil)

          expect(model.titleLabel.text).to(equal(model.title))
        }

        it("sets text to textView") {
          let model = TutorialModel(
            title: "Step I",
            text: "Collect underpants\n💭",
            image: nil)

          expect(model.textView.text).to(equal(model.text))
        }

        it("sets image to imageView") {
          let model = TutorialModel(
            title: nil,
            text: "Thanks for your time.",
            image:ResourceHelper.dummyImage())

          expect(model.imageView.image).to(equal(model.image))
        }
      }

      describe("#views") {
        it("returns the correct views") {
          context("with title only") {
            let model = TutorialModel(
              title: "Step I",
              text: nil,
              image: nil)
            let views = model.views()

            expect(views.count).to(equal(1))
          }

          context("with title and text") {
            let model = TutorialModel(
              title: "Step I",
              text: "Collect underpants\n💭",
              image: nil)
            let views = model.views()

            expect(views.count).to(equal(2))
          }

          context("with title, text are image") {
            let model = TutorialModel(
              title: "Step I",
              text: "Collect underpants\n💭",
              image: ResourceHelper.dummyImage())
            let views = model.views()

            expect(views.count).to(equal(3))
          }
        }
      }
    }
  }
}
