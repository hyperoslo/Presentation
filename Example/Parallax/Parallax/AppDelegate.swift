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
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

      UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
      UINavigationBar.appearance().barStyle = .default
      UINavigationBar.appearance().shadowImage = UIImage()
      UINavigationBar.appearance().isTranslucent = true

      window = UIWindow(frame: UIScreen.main.bounds)
      window?.rootViewController = navigationController
      window?.makeKeyAndVisible()

      return true
  }
}
