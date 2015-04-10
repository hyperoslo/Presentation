import UIKit
import Pages
import Hex

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    let tutorialViewController = TutorialViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)

    let viewController1 = UIViewController()
    viewController1.title = "Welcome"
    tutorialViewController.addPage(viewController1)

    let viewController2 = UIViewController()
    viewController2.title = "This is a tutorial"
    tutorialViewController.addPage(viewController2)

    let navigationController = UINavigationController(rootViewController: tutorialViewController)
    navigationController.view.backgroundColor = UIColor(fromHex:"DAE2EA")
    navigationController.navigationBarHidden = true

    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()

    return true
  }
}

