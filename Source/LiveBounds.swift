import UIKit

extension UIScreen {

  func liveBounds() -> CGRect {
    UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()

    var orientation = UIDevice.currentDevice().orientation
    let statusBarOrientation = UIApplication.sharedApplication().statusBarOrientation

    if (statusBarOrientation == .Portrait ||
      statusBarOrientation == .PortraitUpsideDown) {
        orientation = .Portrait
    } else {
      orientation = .LandscapeLeft
    }

    var bounds = self.bounds
    var width = bounds.size.width
    var height = bounds.size.height

    if UIDeviceOrientationIsPortrait(orientation) {
      if bounds.size.width > height {
        width = bounds.size.height
        height = bounds.size.width
      }
    } else {
      if bounds.size.height > bounds.size.width {
        width = bounds.size.height
        height = bounds.size.width
      }
    }

    bounds.size.width = width
    bounds.size.height = height

    UIDevice.currentDevice().endGeneratingDeviceOrientationNotifications()

    return bounds
  }

}
