import UIKit
import Pages

@objc public protocol PresentationControllerDelegate {

  func presentationController(
    _ presentationController: PresentationController,
    didSetViewController viewController: UIViewController,
    atPage page: Int)
}

open class PresentationController: PagesController {

  open weak var presentationDelegate: PresentationControllerDelegate?
  open var maxAnimationDelay: Double = 3

  fileprivate var backgroundContents = [Content]()
  fileprivate var slides = [SlideController]()
  fileprivate var animationsForPages = [Int : [Animatable]]()

  fileprivate var animationIndex = 0
  fileprivate weak var scrollView: UIScrollView?
  var animationTimer: Timer?

  public convenience init(pages: [UIViewController]) {
    self.init(
      transitionStyle: .scroll,
      navigationOrientation: .horizontal,
      options: nil)

    add(pages)
  }

  // MARK: - View lifecycle

  open override func viewDidLoad() {
    pagesDelegate = self

    super.viewDidLoad()
  }

  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    for subview in view.subviews {
      if subview is UIScrollView {
        scrollView = subview as? UIScrollView
        scrollView?.delegate = self
      }
    }

    animateAtIndex(0, perform: { animation in
      animation.play()
    })
  }

  // MARK: - Public methods

  open override func goTo(_ index: Int) {
    startAnimationTimer()
    
    super.goTo(index)

    if index >= 0 && index < pagesCount {
      let reverse = index < animationIndex
      if !reverse {
        animationIndex = index
      }

      for slide in slides {
        if reverse {
          slide.goToLeft()
        } else {
          slide.goToRight()
        }
      }

      scrollView?.delegate = nil

      animateAtIndex(animationIndex, perform: { animation in
        if reverse {
          animation.playBack()
        } else {
          animation.play()
        }
      })
    }
  }

  // MARK: - Animation Timer

  func startAnimationTimer() {
    stopAnimationTimer()
    scrollView?.isUserInteractionEnabled = false
    if animationTimer == nil {
      DispatchQueue.main.async {
        self.animationTimer = Timer.scheduledTimer(timeInterval: self.maxAnimationDelay,
          target: self,
          selector: #selector(self.updateAnimationTimer(_:)),
          userInfo: nil,
          repeats: false)
        RunLoop.current.add(self.animationTimer!, forMode: RunLoopMode.commonModes)
      }
    }
  }

  func stopAnimationTimer() {
    animationTimer?.invalidate()
    animationTimer = nil
  }

  func updateAnimationTimer(_ timer: Timer) {
    stopAnimationTimer()
    scrollView?.isUserInteractionEnabled = true
  }
}

// MARK: - Content

extension PresentationController {

  open override func add(_ viewControllers: [UIViewController]) {
    for case let controller as SlideController in viewControllers  {
      slides.append(controller)
    }
    super.add(viewControllers)
  }

  public func addToBackground(_ elements: [Content]) {
    for content in elements {
      backgroundContents.append(content)
      view.addSubview(content.view)
      view.sendSubview(toBack: content.view)
      content.layout()
    }
  }
}

// MARK: - Animations

extension PresentationController {

  public func addAnimations(_ animations: [Animatable], forPage page: Int) {
    for animation in animations {
      addAnimation(animation, forPage: page)
    }
  }

  public func addAnimation(_ animation: Animatable, forPage page: Int) {
    if animationsForPages[page] == nil {
      animationsForPages[page] = []
    }
    animationsForPages[page]?.append(animation)
  }

  fileprivate func animateAtIndex(_ index: Int, perform: (_ animation: Animatable) -> Void) {
    if let animations = animationsForPages[index] {
      for animation in animations {
        perform(animation)
      }
    }
  }
}

// MARK: - PagesControllerDelegate

extension PresentationController: PagesControllerDelegate {

  open func pageViewController(_ pageViewController: UIPageViewController,
    setViewController viewController: UIViewController, atPage page: Int) {
      animationIndex = page
      scrollView?.delegate = self

      presentationDelegate?.presentationController(self,
        didSetViewController: viewController,
        atPage: page)
  }
}

// MARK: - UIScrollViewDelegate

extension PresentationController: UIScrollViewDelegate {

  open func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.x - (view.frame).width
    let offsetRatio = offset / (view.frame).width

    var index = animationIndex
    if offsetRatio > 0.0 || index == 0 {
      index += 1
    }

    let canMove = offsetRatio != 0.0 &&
      !(animationIndex == 0 && offsetRatio < 0.0) &&
      !(index == pagesCount)

    if canMove {
      animateAtIndex(index, perform: { animation in
        animation.moveWith(offsetRatio: offsetRatio)
      })
      for slide in slides {
        if index <= animationIndex {
          slide.goToLeft()
        } else {
          slide.goToRight()
        }
      }
    }

    scrollView.layoutIfNeeded()
    view.layoutIfNeeded()
  }
}
