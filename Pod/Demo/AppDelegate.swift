import UIKit
import Pages

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var tutorialViewController: TutorialViewController = {
    let tutorialViewController = TutorialViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    return tutorialViewController
    }()

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    let viewController1 = UIViewController()
    viewController1.view.backgroundColor = UIColor.lightGrayColor()
    viewController1.title = "Welcome"

    tutorialViewController.addPage(viewController1)

    let navigationController = UINavigationController(rootViewController: self.tutorialViewController)

    self.tutorialViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Previous Page", style: .Plain, target: self.tutorialViewController, action: "previousPage")

    self.tutorialViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next Page", style: .Plain, target: self.tutorialViewController, action: "nextPage")

    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()

    return true
  }
}

