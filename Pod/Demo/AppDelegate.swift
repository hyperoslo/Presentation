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

      addScene()
      addSlides()

      window = UIWindow(frame: UIScreen.mainScreen().bounds)
      window?.rootViewController = navigationController
      window?.makeKeyAndVisible()

      return true
  }

  func addScene() {
    let images = ["cloud1", "cloud2", "cloud1"].map { UIImageView(image: UIImage(named: $0)) }
    images[0].tag = 1002

    let content1 = SceneContent(view: images[0], position: Position(left: -0.3, top: 0.2), animations: [
      TransitionAnimation(destination: Position(left: 0.2, top: 0.2), duration: 1.0),
      TransitionAnimation(destination: Position(left: 0.3, top: 0.2)),
      TransitionAnimation(destination: Position(left: 0.4, top: 0.2)),
      TransitionAnimation(destination: Position(left: 0.6, top: 0.2)),
      TransitionAnimation(destination: Position(left: 0.8, top: 0.2))])

    let content2 = SceneContent(view: images[1], position: Position(right: -0.3, top: 0.22), animations: [
      TransitionAnimation(destination: Position(right: 0.3, top: 0.22), duration: 1.0),
      TransitionAnimation(destination: Position(right: 0.4, top: 0.22)),
      TransitionAnimation(destination: Position(right: 0.5, top: 0.22)),
      TransitionAnimation(destination: Position(right: 0.7, top: 0.22)),
      TransitionAnimation(destination: Position(right: 0.9, top: 0.22))
      ])

    let content3 = SceneContent(view: images[2], position: Position(left: 0.5, top: 0.5), animations: [
      PopAnimation(duration: 1.0)])

    tutorialController.addToScene([content1, content2, content3])
  }

  func addSlides() {
    let font = UIFont(name: "ArialRoundedMTBold", size: 42.0)!
    let color = UIColor.whiteColor()
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = NSTextAlignment.Center

    let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: color,
      NSParagraphStyleAttributeName: paragraphStyle]

    let titles = ["Tutorial on how to make a profit", "Step I", "Step II", "Step III", "Thanks"].map {
      SlideContent.titleContent($0, attributes: attributes, animated: false)
    }
    let texts = ["", "Collect underpants\n💭", "🎅🎅🏻🎅🏼🎅🏽🎅🏾🎅🏿", "Profit\n💸", ""].map {
      SlideContent.textContent($0, attributes: attributes, animated: false)
    }

    var slides = [[SlideContent]]()
    for index in 0...4 {
      slides.append([titles[index], texts[index]])
    }
    slides[4].append(SlideContent.imageContent(UIImage(named: "hyper-logo")!, animated: false))

    tutorialController.addSlides(slides)
  }

  func resetPages() {
    tutorialController.goTo(0)
  }
}

