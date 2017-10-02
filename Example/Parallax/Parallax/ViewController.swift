import UIKit
import Hue
import Presentation

class ViewController: PresentationController {
  private struct BackgroundImage {
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

    func positionAt(_ index: Int) -> Position? {
      var position: Position?

      if index == 0 || speed != 0.0 {
        let currentLeft = left + CGFloat(index) * speed
        position = Position(left: currentLeft, top: top)
      }

      return position
    }
  }

  private lazy var leftButton: UIBarButtonItem = { [unowned self] in
    let leftButton = UIBarButtonItem(
      title: "Previous",
      style: .plain,
      target: self,
      action: #selector(moveBack))

    leftButton.setTitleTextAttributes(
      [NSAttributedStringKey.foregroundColor : UIColor.black],
      for: .normal
    )

    return leftButton
  }()

  private lazy var rightButton: UIBarButtonItem = { [unowned self] in
    let rightButton = UIBarButtonItem(
      title: "Next",
      style: .plain,
      target: self,
      action: #selector(moveForward)
    )

    rightButton.setTitleTextAttributes(
      [NSAttributedStringKey.foregroundColor : UIColor.black],
      for: .normal
    )

    return rightButton
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setNavigationTitle = false
    navigationItem.leftBarButtonItem = leftButton
    navigationItem.rightBarButtonItem = rightButton
    view.backgroundColor = UIColor(hex: "FFBC00")

    configureSlides()
    configureBackground()
  }

  // MARK: - Configuration

  private func configureSlides() {
    let ratio: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.6
    let font = UIFont(name: "HelveticaNeue", size: 34.0 * ratio)!
    let color = UIColor(hex: "FFE8A9")
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = NSTextAlignment.center

    let attributes = [
      NSAttributedStringKey.font: font,
      NSAttributedStringKey.foregroundColor: color,
      NSAttributedStringKey.paragraphStyle: paragraphStyle
    ]

    let titles = [
      "Parallax is a displacement or difference in the apparent position of an object viewed along two different lines of sight.",
      "It's measured by the angle or semi-angle of inclination between those two lines.",
      "The term is derived from the Greek word παράλλαξις (parallaxis), meaning 'alteration'.",
      "Nearby objects have a larger parallax than more distant objects when observed from different positions.",
      "http://en.wikipedia.org/wiki/Parallax"].map { title -> Content in
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 550 * ratio, height: 200 * ratio))
        label.numberOfLines = 5
        label.attributedText = NSAttributedString(string: title, attributes: attributes)
        let position = Position(left: 0.7, top: 0.35)

        return Content(view: label, position: position)
    }

    var slides = [SlideController]()

    for index in 0...4 {
      let controller = SlideController(contents: [titles[index]])
      controller.add(animations: [Content.centerTransition(forSlideContent: titles[index])])
      slides.append(controller)
    }

    add(slides)
  }

  private func configureBackground() {
    let backgroundImages = [
      BackgroundImage(name: "Trees", left: 0.0, top: 0.743, speed: -0.3),
      BackgroundImage(name: "Bus", left: 0.02, top: 0.77, speed: 0.25),
      BackgroundImage(name: "Truck", left: 1.3, top: 0.73, speed: -1.5),
      BackgroundImage(name: "Roadlines", left: 0.0, top: 0.79, speed: -0.24),
      BackgroundImage(name: "Houses", left: 0.0, top: 0.627, speed: -0.16),
      BackgroundImage(name: "Hills", left: 0.0, top: 0.51, speed: -0.08),
      BackgroundImage(name: "Mountains", left: 0.0, top: 0.29, speed: 0.0),
      BackgroundImage(name: "Clouds", left: -0.415, top: 0.14, speed: 0.18),
      BackgroundImage(name: "Sun", left: 0.8, top: 0.07, speed: 0.0)
    ]

    var contents = [Content]()

    for backgroundImage in backgroundImages {
      let imageView = UIImageView(image: UIImage(named: backgroundImage.name))
      if let position = backgroundImage.positionAt(0) {
        contents.append(Content(view: imageView, position: position, centered: false))
      }
    }

    addToBackground(contents)

    for row in 1...4 {
      for (column, backgroundImage) in backgroundImages.enumerated() {
        if let position = backgroundImage.positionAt(row), let content = contents.at(column) {
          addAnimation(TransitionAnimation(content: content, destination: position,
                                           duration: 2.0, damping: 1.0), forPage: row)
        }
      }
    }

    let groundView = UIView(frame: CGRect(x: 0, y: 0, width: 1024, height: 60))
    groundView.backgroundColor = UIColor(hex: "FFCD41")

    let groundContent = Content(
      view: groundView,
      position: Position(left: 0.0, bottom: 0.063),
      centered: false
    )

    contents.append(groundContent)
    addToBackground([groundContent])
  }
}

private extension Array {
  func at(_ index: Int?) -> Element? {
    var object: Element?
    if let index = index , index >= 0 && index < endIndex {
      object = self[index]
    }

    return object
  }
}
