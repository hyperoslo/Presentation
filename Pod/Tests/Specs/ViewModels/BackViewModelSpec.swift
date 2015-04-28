import Quick
import Nimble

class BackViewModelSpec: QuickSpec {

  override func spec() {
    describe("BackViewModel") {
      var model: BackViewModel!

      beforeEach {
        model = BackViewModel(view: dummyImage(),
          position: TutorialViewPosition(xPercentage: 0.3, yPercentage: 0.3, hMargin: .Right, vMargin: .Bottom))
      }

      describe("#place") {
      }
    }
  }

}

// MARK: Helpers

private func dummyImage() -> UIImage? {
  let bundle = NSBundle(forClass: TutorialModelSpec.self)

  var image: UIImage? = nil
  if let imagePath = bundle.pathForResource("hyper-logo", ofType: "png") {
    image = UIImage(contentsOfFile: imagePath)
  }

  return image
}
