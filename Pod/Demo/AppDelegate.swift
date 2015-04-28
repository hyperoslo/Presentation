import UIKit
import Pages
import Hex
import Tutorial

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

      addPages()
      addAnimations()
      addBackgroundViews()

      window = UIWindow(frame: UIScreen.mainScreen().bounds)
      window?.rootViewController = navigationController
      window?.makeKeyAndVisible()

      return true
  }

  func addPages() {
    let font = UIFont(name: "ArialRoundedMTBold", size: 42.0)!
    let color = UIColor.whiteColor()
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = NSTextAlignment.Center

    let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: color,
      NSParagraphStyleAttributeName: paragraphStyle]

    let model1 = ContentViewModel(
      title: "Tutorial on how to make a profit",
      text: nil,
      image: nil)
    model1.setTitleAttributes(attributes)
    model1.setTextAttributes(attributes)

    let model2 = ContentViewModel(
      title: "Step I",
      text: "Collect underpants\n💭",
      image: nil)
    model2.setTitleAttributes(attributes)
    model2.setTextAttributes(attributes)

    let model3 = ContentViewModel(
      title: "Step II",
      text: "🎅🎅🏻🎅🏼🎅🏽🎅🏾🎅🏿",
      image: nil)
    model3.setTitleAttributes(attributes)
    model3.setTextAttributes(attributes)

    let model4 = ContentViewModel(
      title: "Step III",
      text: "Profit\n💸",
      image: nil)
    model4.setTitleAttributes(attributes)
    model4.setTextAttributes(attributes)

    let model5 = ContentViewModel(
      title: nil,
      text: "Thanks for your time.",
      image:UIImage(named: "hyper-logo"))
    model5.setTitleAttributes(attributes)
    model5.setTextAttributes(attributes)

    let page1 = UIViewController(model: model1)
    let page2 = UIViewController(model: model2)
    let page3 = UIViewController(model: model3)
    let page4 = UIViewController(model: model4)
    let page5 = UIViewController(model: model5)

    tutorialController.add([page1, page2, page3, page4, page5])
  }

  func addBackgroundViews() {
    let cloudView1 = UIImageView(image: UIImage(named: "cloud1"))
    let backViewModel1 = BackViewModel(view: cloudView1,
      position: Position(left: 0.7, top: 0.7))

    tutorialController.addBackViewModels([backViewModel1])
  }

  func addAnimations() {
    let image1 = UIImageView(image: UIImage(named: "cloud1"))
    let image2 = UIImageView(image: UIImage(named: "cloud2"))
    let image3 = UIImageView(image: UIImage(named: "cloud1"))
    let image4 = UIImageView(image: UIImage(named: "cloud2"))

    tutorialController.addAnimations(
      [
        LeftAppearanceAnimation(view: image1,
          destination: Position(left: 0.1, top: 0.1),
          duration: 1.0),
        RightAppearanceAnimation(view: image2,
          destination: Position(right: 0.2, top: 0.12),
          duration: 1.0),
        PopAppearanceAnimation(view: image3,
          destination: Position(left: 0.4, top: 0.5),
          duration: 1.0)
      ],
      forPage: 0)

    tutorialController.addAnimations(
      [
        TransitionAnimation(view: image1,
          destination: Position(left: 0.2, top: 0.1)),
        TransitionAnimation(view: image2,
          destination: Position(right: 0.3, top: 0.12)),
        RightAppearanceAnimation(view: image4,
          destination: Position(right: 0.4, top: 0.35),
          duration: 1.0),
      ],
      forPage: 1)

    tutorialController.addAnimations(
      [
        TransitionAnimation(view: image1,
          destination: Position(left: 0.3, top: 0.1)),
        TransitionAnimation(view: image2,
          destination: Position(right: 0.4, top: 0.12))
      ],
      forPage: 2)

    tutorialController.addAnimations(
      [
        TransitionAnimation(view: image1,
          destination: Position(left: 0.5, top: 0.1)),
        TransitionAnimation(view: image2,
          destination: Position(right: 0.6, top: 0.12))
      ],
      forPage: 3)

    tutorialController.addAnimations(
      [
        TransitionAnimation(view: image1,
          destination: Position(left: 0.7, top: 0.1)),
        TransitionAnimation(view: image2,
          destination: Position(right: 0.8, top: 0.12))
      ],
      forPage: 4)
  }

  func resetPages() {
    tutorialController.goTo(0)
  }
}

