import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let viewController = TutorialViewController(title: "Tutorial")
        let bounds = UIScreen.mainScreen().bounds;
        let view1 = UIView(frame: bounds)
        view1.backgroundColor = UIColor.greenColor()
        let view2 = UIView(frame: bounds)
        view2.backgroundColor = UIColor.yellowColor()
        viewController.addPage(view1)
        viewController.addPage(view2)

        let navigationController = UINavigationController(rootViewController: viewController)

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        return true
    }
}

