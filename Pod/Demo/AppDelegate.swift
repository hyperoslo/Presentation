import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var tutorialViewController: TutorialViewController = {
    let tutorialViewController = TutorialViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    return tutorialViewController
    }()

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    let viewController1 = UIViewController()
    viewController1.view.backgroundColor = UIColor.redColor()
    let viewController2 = UIViewController()
    viewController2.view.backgroundColor = UIColor.blueColor()
    let viewController3 = UIViewController()
    viewController3.view.backgroundColor = UIColor.greenColor()
    let viewController4 = UIViewController()
    viewController4.view.backgroundColor = UIColor.yellowColor()

    tutorialViewController.addPage(viewController1)
    tutorialViewController.addPage(viewController2)
    tutorialViewController.addPage(viewController3)
    tutorialViewController.addPage(viewController4)

    let navigationController = UINavigationController(rootViewController: self.tutorialViewController)

    self.tutorialViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Previous Page", style: .Plain, target: self, action: "previousPage")

    self.tutorialViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next Page", style: .Plain, target: self, action: "nextPage")

    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()

    return true
  }

  //    func nextPage() {
  //        var currentIndex = self.tutorialViewController.currentPage
  //        self.tutorialViewController.goToPage(currentIndex)
  //    }
  //
  //    func previousPage() {
  //        var currentIndex = self.tutorialViewController.currentPage
  //        self.tutorialViewController.goToPage(currentIndex)
  //    }
}

