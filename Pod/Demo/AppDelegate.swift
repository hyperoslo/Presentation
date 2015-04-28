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

      let font = UIFont(name: "ArialRoundedMTBold", size: 42.0)!
      let color = UIColor.whiteColor()
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = NSTextAlignment.Center

      let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: color,
        NSParagraphStyleAttributeName: paragraphStyle]

      let model1 = TutorialModel(
        title: "Tutorial on how to make a profit",
        text: nil,
        image: nil)
      model1.setTitleAttributes(attributes)
      model1.setTextAttributes(attributes)

      let model2 = TutorialModel(
        title: "Step I",
        text: "Collect underpants\n💭",
        image: nil)
      model2.setTitleAttributes(attributes)
      model2.setTextAttributes(attributes)

      let model3 = TutorialModel(
        title: "Step II",
        text: "🎅🎅🏻🎅🏼🎅🏽🎅🏾🎅🏿",
        image: nil)
      model3.setTitleAttributes(attributes)
      model3.setTextAttributes(attributes)

      let model4 = TutorialModel(
        title: "Step III",
        text: "Profit\n💸",
        image: nil)
      model4.setTitleAttributes(attributes)
      model4.setTextAttributes(attributes)

      let model5 = TutorialModel(
        title: nil,
        text: "Thanks for your time.",
        image:UIImage(named: "hyper-logo.png"))
      model5.setTitleAttributes(attributes)
      model5.setTextAttributes(attributes)

      let page1 = UIViewController(model: model1)
      let page2 = UIViewController(model: model2)
      let page3 = UIViewController(model: model3)
      let page4 = UIViewController(model: model4)
      let page5 = UIViewController(model: model5)

      let cloudView1 = UIImageView(image: UIImage(named: "cloud1"))
      let cloudView2 = UIImageView(image: UIImage(named: "cloud2"))

     //tutorialController.addViewsToBack([cloudView1, cloudView2])

      tutorialController.addAnimation(
        LeftAppearanceAnimation(view: cloudView1,
          destination: TutorialViewPosition(xPercentage: 0.1, yPercentage: 0.1, hMargin: .Left, vMargin: .Top)),
          forPage: 0)

      tutorialController.addAnimation(
        RightAppearanceAnimation(view: cloudView2,
          destination: TutorialViewPosition(xPercentage: 0.2, yPercentage: 0.12, hMargin: .Right, vMargin: .Top)),
          forPage: 0)

      tutorialController.addAnimation(
        TransitionAnimation(view: cloudView1,
          destination: TutorialViewPosition(xPercentage: 0.2, yPercentage: 0.1, hMargin: .Left, vMargin: .Top)),
          forPage: 1)

      tutorialController.addAnimation(
        TransitionAnimation(view: cloudView2,
          destination: TutorialViewPosition(xPercentage: 0.3, yPercentage: 0.12, hMargin: .Right, vMargin: .Top)),
          forPage: 1)

      tutorialController.add([page1, page2, page3, page4, page5])

      window = UIWindow(frame: UIScreen.mainScreen().bounds)
      window?.rootViewController = navigationController
      window?.makeKeyAndVisible()

      return true
  }

  func resetPages() {
    tutorialController.goTo(0)
  }
}

