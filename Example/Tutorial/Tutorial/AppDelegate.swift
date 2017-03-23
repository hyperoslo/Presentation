import UIKit
import Hue
import Presentation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  lazy var navigationController: UINavigationController = { [unowned self] in
    let controller = UINavigationController(rootViewController: self.presentationController)
    controller.view.backgroundColor = UIColor(hex:"FF5703")

    return controller
  }()

  lazy var presentationController: PresentationController = {
    let controller = PresentationController(pages: [])
    controller.setNavigationTitle = false

    return controller
    }()

  lazy var leftButton: UIBarButtonItem = { [unowned self] in
    let button = UIBarButtonItem(
      title: "Previous page",
      style: .plain,
      target: self.presentationController,
      action: #selector(PresentationController.moveBack))

    button.setTitleTextAttributes(
      [NSForegroundColorAttributeName : UIColor.white],
      for: .normal)

    return button
    }()

  lazy var rightButton: UIBarButtonItem = { [unowned self] in
    let button = UIBarButtonItem(
      title: "Next page",
      style: .plain,
      target: self.presentationController,
      action: #selector(PresentationController.moveForward))

    button.setTitleTextAttributes(
      [NSForegroundColorAttributeName : UIColor.white],
      for: .normal)

    return button
    }()

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

      UINavigationBar.appearance().barTintColor = UIColor(hex: "FF5703")
      UINavigationBar.appearance().barStyle = .blackTranslucent

      presentationController.navigationItem.leftBarButtonItem = leftButton
      presentationController.navigationItem.rightBarButtonItem = rightButton

      configureSlides()
      configureBackground()

      window = UIWindow(frame: UIScreen.main.bounds)
      window?.rootViewController = navigationController
      window?.makeKeyAndVisible()

      return true
  }

  func configureSlides() {
    let ratio: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.4
    let font = UIFont(name: "ArialRoundedMTBold", size: 42.0 * ratio)!
    let color = UIColor.white
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center

    let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: color,
      NSParagraphStyleAttributeName: paragraphStyle]

    let titles = ["Tutorial on how to make a profit", "Step I", "Step II", "Step III", "Thanks"].map {
      Content.content(forTitle: $0, attributes: attributes)
    }
    let texts = ["", "Collect underpants\n💭", "🎅🎅🏻🎅🏼🎅🏽🎅🏾🎅🏿", "Profit\n💸", ""].map {
      Content.content(forText: $0, attributes: attributes)
    }

    var slides = [SlideController]()

    for index in 0...4 {
      let controller = SlideController(contents: [titles[index], texts[index]])

      if index == 0 {
        titles[index].position.left = 0.5

        controller.add(animations: [
          DissolveAnimation(content: titles[index], duration: 2.0, delay: 1.0, initial: true)])
      } else {
        controller.add(animations: [
          Content.centerTransition(forSlideContent: titles[index]),
          Content.centerTransition(forSlideContent: texts[index])])
      }

      slides.append(controller)
    }

    slides[4].add(content: Content.content(forImage: UIImage(named: "HyperLogo")!))

    presentationController.add(slides)
  }

  func configureBackground() {
    let images = ["Cloud1", "Cloud2", "Cloud1"].map { UIImageView(image: UIImage(named: $0)) }

    let content1 = Content(view: images[0], position: Position(left: -0.3, top: 0.2))
    let content2 = Content(view: images[1], position: Position(right: -0.3, top: 0.22))
    let content3 = Content(view: images[2], position: Position(left: 0.5, top: 0.5))

    presentationController.addToBackground([content1, content2, content3])

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
}

