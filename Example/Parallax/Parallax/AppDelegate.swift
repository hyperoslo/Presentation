import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  lazy var navigationController: UINavigationController = { [unowned self] in
    let controller = UINavigationController(rootViewController: self.presentationController)

    return controller
    }()

  lazy var presentationController: ViewController = {
    return ViewController(pages: [])
    }()

  func application(
    application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

      UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
      UINavigationBar.appearance().barStyle = .Default
      UINavigationBar.appearance().shadowImage = UIImage()
      UINavigationBar.appearance().translucent = true

      window = UIWindow(frame: UIScreen.mainScreen().bounds)
      window?.rootViewController = navigationController
      window?.makeKeyAndVisible()

      return true
  }
}
