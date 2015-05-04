import UIKit
import Hex
import Presentation

class ViewController: PresentationController {

  struct SceneImage {
    let name: String
    let left: CGFloat
    let top: CGFloat
    let speed: CGFloat

    init(name: String, left: CGFloat, top: CGFloat, speed: CGFloat) {
      self.name = name
      self.left = left
      self.top = top
      self.speed = speed
    }

    func positionAt(index: Int) -> Position? {
      var position: Position?

      if index == 0 || speed != 0.0 {
        let currentLeft = left + CGFloat(index) * speed
        position = Position(left: currentLeft, top: top)
      }

      return position
    }
  }

  lazy var leftButton: UIBarButtonItem = { [unowned self] in
    let leftButton = UIBarButtonItem(
      title: "Previous",
      style: .Plain,
      target: self,
      action: "previous")

    leftButton.setTitleTextAttributes(
      [NSForegroundColorAttributeName : UIColor.blackColor()],
      forState: .Normal)

    return leftButton
    }()

  lazy var rightButton: UIBarButtonItem = { [unowned self] in
    let rightButton = UIBarButtonItem(
      title: "Next",
      style: .Plain,
      target: self,
      action: "next")

    rightButton.setTitleTextAttributes(
      [NSForegroundColorAttributeName : UIColor.blackColor()],
      forState: .Normal)

    return rightButton
    }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setNavigationTitle = false
    navigationItem.leftBarButtonItem = leftButton
    navigationItem.rightBarButtonItem = rightButton

    view.backgroundColor = UIColor(fromHex: "FFBC00")

    configureSlides()
    configureScene()
  }

  // MARK: - Configuration

  func configureSlides() {
    let font = UIFont(name: "HelveticaNeue", size: 42.0)!
    let color = UIColor.blackColor()
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = NSTextAlignment.Center

    let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: color,
      NSParagraphStyleAttributeName: paragraphStyle]

    let titles = [
      "What tools do we usually use to make a cool presentation? Keynote, PowerPoint, Google Slides...",
      "But what if we need a presentation within our iOS app? From app to app we make tutorials, release notes and different kind of animatable slides.",
      "What could we do there? Build something from scratch every time? Defenetely, no. We are lazy developers and always want to have something universal that we could re-use.",
      "In iOS development world - Pod - library ad off course open source.",
      "Thanks!"].map { title -> Content in
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 500.0, height: 200.0))
        label.numberOfLines = 5
        label.attributedText = NSAttributedString(string: title, attributes: attributes)
        let position = Position(left: 0.5, top: 0.35)

        return Content(view: label, position: position)
    }

    var slides = [SlideController]()

    for index in 0...4 {
      let controller = SlideController(contents: [titles[index]])
      controller.addAnimations([Content.centerTransitionForSlideContent(titles[index])])

      slides.append(controller)
    }

    add(slides)
  }

  func configureScene() {
    let sceneImages = [
      SceneImage(name: "Trees", left: 0.0, top: 0.743, speed: -0.3),
      SceneImage(name: "Bus", left: 0.02, top: 0.77, speed: 0.25),
      SceneImage(name: "Truck", left: 1.3, top: 0.73, speed: -1.5),
      SceneImage(name: "Roadlines", left: 0.0, top: 0.79, speed: -0.24),
      SceneImage(name: "Houses", left: 0.0, top: 0.627, speed: -0.16),
      SceneImage(name: "Hills", left: 0.0, top: 0.51, speed: -0.08),
      SceneImage(name: "Mountains", left: 0.0, top: 0.29, speed: 0.0),
      SceneImage(name: "Clouds", left: -0.415, top: 0.14, speed: 0.18),
      SceneImage(name: "Sun", left: 0.8, top: 0.07, speed: 0.0)
    ]

    var contents = [Content]()

    for sceneImage in sceneImages {
      let imageView = UIImageView(image: UIImage(named: sceneImage.name))
      if let position = sceneImage.positionAt(0) {
        contents.append(Content(view: imageView, position: position, centered: false))
      }
    }

    addToScene(contents)

    for i in 1...4 {
      for (j, sceneImage) in enumerate(sceneImages) {
        if let position = sceneImage.positionAt(i), content = contents.at(j) {
          addAnimation(TransitionAnimation(content: content, destination: position,
            duration: 2.0, dumping: 1.0), forPage: i)
        }
      }
    }

    let groundView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 1024.0, height: 60.0))
    groundView.backgroundColor = UIColor(fromHex: "FFCD41")
    let groundContent = Content(view: groundView,
      position: Position(left: 0.0, bottom: 0.063), centered: false)
    contents.append(groundContent)

    addToScene([groundContent])
  }
}

extension Array {

  func at(index: Int?) -> T? {
    var object: T?
    if let index = index where index >= 0 && index < endIndex {
      object = self[index]
    }

    return object
  }
}
