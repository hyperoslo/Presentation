import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tutorialViewController: TutorialViewController = {
        return TutorialViewController(title: "Tutorial")
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let bounds = UIScreen.mainScreen().liveBounds();
        let view1 = UIView(frame: bounds)
        view1.backgroundColor = UIColor.greenColor()
        let view2 = UIView(frame: bounds)
        view2.backgroundColor = UIColor.yellowColor()
        self.tutorialViewController.addPage(view1)
        self.tutorialViewController.addPage(view2)

        let navigationController = UINavigationController(rootViewController: self.tutorialViewController)

        self.tutorialViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Previous Page", style: .Plain, target: self, action: "previousPage")

        self.tutorialViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next Page", style: .Plain, target: self, action: "nextPage")

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        return true
    }

    func nextPage() {
        var currentIndex = self.tutorialViewController.currentPage
        self.tutorialViewController.currentPage = currentIndex + 1
    }

    func previousPage() {
        var currentIndex = self.tutorialViewController.currentPage
        self.tutorialViewController.currentPage = currentIndex - 1
    }
}

