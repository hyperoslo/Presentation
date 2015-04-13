import UIKit
import Pages
import Hex

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  lazy var tutorialController = {TutorialController(pages: [])}()

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    self.tutorialController.setNavigationTitle = false

    let bounds = UIScreen.mainScreen().bounds
    let page1 = UIViewController()
    page1.title = "Tutorial on how to make a profit"

    let page2 = UIViewController()
    page2.title = "Step I.\nCollect underpants\n💭"

    let page3 = UIViewController()
    page3.title = "Step II.\n???\n🎅🎅🏻🎅🏼🎅🏽🎅🏾🎅🏿\n"

    let page4 = UIViewController()
    page4.title = "Step III.\nProfit\n💸"

    let page5 = UIViewController()
    page5.title = "Thanks for your time."

    let logoSize: CGFloat = 100.0
    let hyperlogo = UIImageView(frame: CGRectMake(
      bounds.size.width / 2 - logoSize / 2,
      bounds.size.height / 2 - logoSize / 2,
      logoSize,
      logoSize))
    hyperlogo.image = UIImage(named: "hyper-logo.png")
    hyperlogo.autoresizingMask = .FlexibleLeftMargin | .FlexibleRightMargin
    hyperlogo.userInteractionEnabled = true

    let restartTap = UITapGestureRecognizer(target: self,
      action: "resetPages")
    hyperlogo.addGestureRecognizer(restartTap)

    page5.view.addSubview(hyperlogo)

    tutorialController.titleColor = UIColor(fromHex: "FFFFFF")
    tutorialController.titleFont = UIFont(name: "ArialRoundedMTBold ", size: 48.0)
    tutorialController.add([page1,page2,page3,page4,page5])

    let navigationController = UINavigationController(rootViewController: tutorialController)
    navigationController.view.backgroundColor = UIColor(fromHex:"FF5703")

    UINavigationBar.appearance().barTintColor = UIColor(fromHex:"FF5703")
    UINavigationBar.appearance().barStyle = UIBarStyle.BlackTranslucent

    let leftButton = UIBarButtonItem(title: "Previous Page", style: .Plain, target: tutorialController, action: "previousPage")
    let rightButton = UIBarButtonItem(title: "Next Page", style: .Plain, target: tutorialController, action: "nextPage")

    leftButton.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], forState: .Normal)
    rightButton.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], forState: .Normal)

    tutorialController.navigationItem.leftBarButtonItem = leftButton
    tutorialController.navigationItem.rightBarButtonItem = rightButton

    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()

    return true
  }

  func resetPages() {
    tutorialController.goto(0)
  }
}

