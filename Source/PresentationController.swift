import UIKit
import Pages

@objc public protocol PresentationControllerDelegate {

  func presentationController(
    presentationController: PresentationController,
    didSetViewController viewController: UIViewController,
    atPage page: Int)
}

public class PresentationController: PagesController {

  public weak var presentationDelegate: PresentationControllerDelegate?
  public var maxAnimationDelay: Double = 3

  private var backgroundContents = [Content]()
  private var slides = [SlideController]()
  private var animationsForPages = [Int : [Animatable]]()

  private var animationIndex = 0
  private weak var scrollView: UIScrollView?
  var animationTimer: NSTimer?

  public convenience init(pages: [UIViewController]) {
    self.init(
      transitionStyle: .Scroll,
      navigationOrientation: .Horizontal,
      options: nil)

    add(pages)
  }

  // MARK: - View lifecycle

  public override func viewDidLoad() {
    pagesDelegate = self

    super.viewDidLoad()
  }

  public override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    for subview in view.subviews{
      if subview.isKindOfClass(UIScrollView) {
        scrollView = subview as? UIScrollView
        scrollView?.delegate = self
      }
    }

    animateAtIndex(0, perform: { animation in
      animation.play()
    })
  }

  // MARK: - Public methods

  public override func goTo(index: Int) {
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
    scrollView?.userInteractionEnabled = false
    if animationTimer == nil {
      dispatch_async(dispatch_get_main_queue()) {
        self.animationTimer = NSTimer.scheduledTimerWithTimeInterval(self.maxAnimationDelay,
          target: self,
          selector: "updateAnimationTimer:",
          userInfo: nil,
          repeats: false)
        NSRunLoop.currentRunLoop().addTimer(self.animationTimer!, forMode: NSRunLoopCommonModes)
      }
    }
  }

  func stopAnimationTimer() {
    animationTimer?.invalidate()
    animationTimer = nil
  }

  func updateAnimationTimer(timer: NSTimer) {
    stopAnimationTimer()
    scrollView?.userInteractionEnabled = true
  }
}

// MARK: - Content

extension PresentationController {

  public override func add(viewControllers: [UIViewController]) {
    for controller in viewControllers {
      if controller is SlideController {
        slides.append((controller as! SlideController))
      }
    }
    super.add(viewControllers)
  }

  public func addToBackground(elements: [Content]) {
    for content in elements {
      backgroundContents.append(content)
      view.addSubview(content.view)
      view.sendSubviewToBack(content.view)
      content.layout()
    }
  }
}

// MARK: - Animations

extension PresentationController {

  public func addAnimations(animations: [Animatable], forPage page: Int) {
    for animation in animations {
      addAnimation(animation, forPage: page)
    }
  }

  public func addAnimation(animation: Animatable, forPage page: Int) {
    if animationsForPages[page] == nil {
      animationsForPages[page] = []
    }
    animationsForPages[page]?.append(animation)
  }

  private func animateAtIndex(index: Int, perform: (animation: Animatable) -> Void) {
    if let animations = animationsForPages[index] {
      for animation in animations {
        perform(animation: animation)
      }
    }
  }
}

// MARK: - PagesControllerDelegate

extension PresentationController: PagesControllerDelegate {

  public func pageViewController(pageViewController: UIPageViewController,
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

  public func scrollViewDidScroll(scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.x - CGRectGetWidth(view.frame)
    let offsetRatio = offset / CGRectGetWidth(view.frame)

    var index = animationIndex
    if offsetRatio > 0.0 || index == 0 {
      index++
    }

    let canMove = offsetRatio != 0.0 &&
      !(animationIndex == 0 && offsetRatio < 0.0) &&
      !(index == pagesCount)

    if canMove {
      animateAtIndex(index, perform: { animation in
        animation.moveWith(offsetRatio)
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
