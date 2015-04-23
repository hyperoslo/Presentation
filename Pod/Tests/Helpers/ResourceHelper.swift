import UIKit

class ResourceHelper {

  class func dummyImage() -> UIImage? {
    let bundle = NSBundle(forClass: TutorialModelSpec.self)

    var image: UIImage? = nil
    if let imagePath = bundle.pathForResource("hyper-logo", ofType: "png") {
      image = UIImage(contentsOfFile: imagePath)
    }

    return image
  }
}
