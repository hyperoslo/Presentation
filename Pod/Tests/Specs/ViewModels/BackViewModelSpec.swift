import Quick
import Nimble
import UIKit
import Tutorial

class BackViewModelSpec: QuickSpec {

  override func spec() {
    describe("BackViewModel") {
      var model: BackViewModel!

      beforeEach {
        let position = Position(left: 0.2, top: 0.2)
        model = BackViewModel(view: SpecHelper.imageView(), position: position)
      }
    }
  }
}
