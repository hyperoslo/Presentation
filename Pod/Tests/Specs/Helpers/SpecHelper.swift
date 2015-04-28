import UIKit

class SpecHelper {

  class func image() -> UIImage {
    let bundle = NSBundle(forClass: SpecHelper.self)

    var image = UIImage()
    if let imagePath = bundle.pathForResource("hyper-logo", ofType: "png") {
      if let loadedImage = UIImage(contentsOfFile: imagePath) {
        image = loadedImage
      }
    }

    return image
  }

  class func imageView() -> UIImageView {
    return UIImageView(image: image())
  }
}
