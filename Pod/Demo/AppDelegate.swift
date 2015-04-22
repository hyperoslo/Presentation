import UIKit
import Pages
import Hex

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  lazy var tutorialController: TutorialController = {
    return TutorialController(pages: [])
    }()

  func application(
    application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

      tutorialController.setNavigationTitle = false

      let navigationController = UINavigationController(rootViewController: tutorialController)
      navigationController.view.backgroundColor = UIColor(fromHex:"FF5703")

      UINavigationBar.appearance().barTintColor = UIColor(fromHex:"FF5703")
      UINavigationBar.appearance().barStyle = UIBarStyle.BlackTranslucent

      let leftButton = UIBarButtonItem(
        title: "Previous page",
        style: .Plain,
        target: tutorialController,
        action: "previous")

      leftButton.setTitleTextAttributes(
        [NSForegroundColorAttributeName : UIColor.whiteColor()],
        forState: .Normal)

      let rightButton = UIBarButtonItem(
        title: "Next page",
        style: .Plain,
        target: tutorialController,
        action: "next")

      rightButton.setTitleTextAttributes(
        [NSForegroundColorAttributeName : UIColor.whiteColor()],
        forState: .Normal)

      tutorialController.navigationItem.leftBarButtonItem = leftButton
      tutorialController.navigationItem.rightBarButtonItem = rightButton

      let model1 = TutorialModel(
        title: "Tutorial on how to make a profit",
        text: nil,
        image: nil)

      let model2 = TutorialModel(
        title: "Step I",
        text: "Collect underpants\n💭",
        image: nil)

      let model3 = TutorialModel(
        title: "Step II",
        text: "🎅🎅🏻🎅🏼🎅🏽🎅🏾🎅🏿",
        image: nil)

      let model4 = TutorialModel(
        title: "Step III",
        text: "Profit\n💸",
        image: nil)

      let model5 = TutorialModel(
        title: nil,
        text: "Thanks for your time.",
        image:UIImage(named: "hyper-logo.png"))

      let page1 = UIViewController(model: model1)
      let page2 = UIViewController(model: model2)
      let page3 = UIViewController(model: model3)
      let page4 = UIViewController(model: model4)
      let page5 = UIViewController(model: model5)

      tutorialController.add([page1, page2, page3, page4, page5])

      let font = UIFont(name: "ArialRoundedMTBold", size: 42.0)!
      TutorialController.setFont(font)
      TutorialController.setTextColor(UIColor.whiteColor())

      window = UIWindow(frame: UIScreen.mainScreen().bounds)
      window?.rootViewController = navigationController
      window?.makeKeyAndVisible()

      return true
  }

  func resetPages() {
    tutorialController.goTo(0)
  }
}

