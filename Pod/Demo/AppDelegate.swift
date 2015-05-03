import UIKit
import Hex
import Presentation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  lazy var presentationController: PresentationController = {
    return PresentationController(pages: [])
    }()

  func application(
    application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

      presentationController.setNavigationTitle = false

      let navigationController = UINavigationController(rootViewController: presentationController)
      navigationController.view.backgroundColor = UIColor(fromHex:"FF5703")

      UINavigationBar.appearance().barTintColor = UIColor(fromHex:"FF5703")
      UINavigationBar.appearance().barStyle = UIBarStyle.BlackTranslucent

      let leftButton = UIBarButtonItem(
        title: "Previous page",
        style: .Plain,
        target: presentationController,
        action: "previous")

      leftButton.setTitleTextAttributes(
        [NSForegroundColorAttributeName : UIColor.whiteColor()],
        forState: .Normal)

      let rightButton = UIBarButtonItem(
        title: "Next page",
        style: .Plain,
        target: presentationController,
        action: "next")

      rightButton.setTitleTextAttributes(
        [NSForegroundColorAttributeName : UIColor.whiteColor()],
        forState: .Normal)

      presentationController.navigationItem.leftBarButtonItem = leftButton
      presentationController.navigationItem.rightBarButtonItem = rightButton

      addSlides()
      addScene()

      window = UIWindow(frame: UIScreen.mainScreen().bounds)
      window?.rootViewController = navigationController
      window?.makeKeyAndVisible()

      return true
  }

  func addScene() {
    let images = ["cloud1", "cloud2", "cloud1"].map { UIImageView(image: UIImage(named: $0)) }

    let content1 = Content(view: images[0], position: Position(left: -0.3, top: 0.2))
    let content2 = Content(view: images[1], position: Position(right: -0.3, top: 0.22))
    let content3 = Content(view: images[2], position: Position(left: 0.5, top: 0.5))

    presentationController.addToScene([content1, content2, content3])

    presentationController.addAnimations([
      TransitionAnimation(content: content1, destination: Position(left: 0.2, top: 0.2)),
      TransitionAnimation(content: content2, destination: Position(right: 0.3, top: 0.22)),
      PopAnimation(content: content3, duration: 1.0)
      ], forPage: 0)

    presentationController.addAnimations([
      TransitionAnimation(content: content1, destination: Position(left: 0.3, top: 0.2)),
      TransitionAnimation(content: content2, destination: Position(right: 0.4, top: 0.22))
      ], forPage: 1)

    presentationController.addAnimations([
      TransitionAnimation(content: content1, destination: Position(left: 0.5, top: 0.2)),
      TransitionAnimation(content: content2, destination: Position(right: 0.5, top: 0.22))
      ], forPage: 2)

    presentationController.addAnimations([
      TransitionAnimation(content: content1, destination: Position(left: 0.6, top: 0.2)),
      TransitionAnimation(content: content2, destination: Position(right: 0.7, top: 0.22))
      ], forPage: 3)

    presentationController.addAnimations([
      TransitionAnimation(content: content1, destination: Position(left: 0.8, top: 0.2)),
      TransitionAnimation(content: content2, destination: Position(right: 0.9, top: 0.22))
      ], forPage: 4)
  }

  func addSlides() {
    let font = UIFont(name: "ArialRoundedMTBold", size: 42.0)!
    let color = UIColor.whiteColor()
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = NSTextAlignment.Center

    let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: color,
      NSParagraphStyleAttributeName: paragraphStyle]

    let titles = ["Tutorial on how to make a profit", "Step I", "Step II", "Step III", "Thanks"].map {
      Content.titleContent($0, attributes: attributes)
    }
    let texts = ["", "Collect underpants\n💭", "🎅🎅🏻🎅🏼🎅🏽🎅🏾🎅🏿", "Profit\n💸", ""].map {
      Content.textContent($0, attributes: attributes)
    }

    var slides = [SlideController]()

    for index in 0...4 {
      let controller = SlideController(contents: [titles[index], texts[index]])
      controller.addAnimations([
        Content.centerTransitionForSlideContent(titles[index]),
        Content.centerTransitionForSlideContent(texts[index])])

      slides.append(controller)
    }

    slides[4].addContent(Content.imageContent(UIImage(named: "hyper-logo")!))

    presentationController.add(slides)
  }

  func resetPages() {
    presentationController.goTo(0)
  }
}

