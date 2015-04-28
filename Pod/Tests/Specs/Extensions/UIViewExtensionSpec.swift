import Quick
import Nimble

class UIViewExtensionSpec: QuickSpec {

  override func spec() {
    describe("UIViewExtension") {
      var view: UIView!

      beforeEach {
        view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 80.0))
      }
    }
  }
}
