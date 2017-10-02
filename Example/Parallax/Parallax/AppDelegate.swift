import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  private lazy var navigationController: UINavigationController = .init(
    rootViewController: self.presentationController
  )
  private lazy var presentationController: ViewController = .init(pages: [])

  func application(_ application: UIApplication,
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
