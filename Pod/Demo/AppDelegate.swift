import UIKit
import Pages
import Hex

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    let page1 = UIViewController()
    page1.title = "Tutorial on how to make a profit"

    let page2 = UIViewController()
    page2.title = "Step 1.\n Collect underpants"

    let page3 = UIViewController()
    page3.title = "Step 2.\n ???"

    let page4 = UIViewController()
    page4.title = "Step 3.\n Profit 💸"

    let page5 = UIViewController()
    page5.title = "Thanks for your time."

    let tutorialViewController = Tutorial(pages: [page1,page2,page3,page4,page5])

    let navigationController = UINavigationController(rootViewController: tutorialViewController)
    navigationController.view.backgroundColor = UIColor(fromHex:"DAE2EA")
    navigationController.navigationBarHidden = true

    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()

    return true
  }
}

