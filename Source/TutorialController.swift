import UIKit
import Pages
import Hex

public class TutorialController: PagesController {

  private var scene = [Content]()
  private var slides = [[Content]]()
  private var animations = [Int: [Animation]]()

  private var animationIndex = 0

  private weak var scrollView: UIScrollView?

  public convenience init(pages: [UIViewController]) {
    self.init(
      transitionStyle: .Scroll,
      navigationOrientation: .Horizontal,
      options: nil)

    add(pages)
  }

  public override func viewDidLoad() {
    pagesDelegate = self

    super.viewDidLoad()
  }

  public override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    NSNotificationCenter.defaultCenter().addObserver(
      self,
      selector: "didRotate",
      name: UIDeviceOrientationDidChangeNotification,
      object: nil)

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

  override public func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)

    NSNotificationCenter.defaultCenter().removeObserver(
      self,
      name: UIDeviceOrientationDidChangeNotification,
      object: nil)
  }

  public override func goTo(index: Int) {
    if index > 0 && index < pagesCount {
      let reverse = index < animationIndex
      if !reverse {
        animationIndex = index
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

    super.goTo(index)
  }

  // MARK: device orientation

  func didRotate() {
    for slide in slides {
      for content in slide {
        content.rotate()
      }
    }
    for content in scene {
      content.rotate()
    }
  }
}

// MARK: - Content

extension TutorialController {

  public func addToScene(elements: [Content]) {
    for content in elements {
      scene.append(content)
      view.addSubview(content.view)
      view.sendSubviewToBack(content.view)
      content.layout()
    }
  }

  public func addSlides(elements: [[Content]]) {
    var pages = [UIViewController]()
    for slide in elements {
      let page = UIViewController()

      for content in slide {
        page.view.addSubview(content.view)
        content.layout()
      }
      slides.append(slide)
      pages.append(page)
    }
    add(pages)
  }

  private func animateAtIndex(index: Int, perform: (animation: Animation) -> Void) {
    if let animations = animations[index] {
      for animation in animations {
        perform(animation: animation)
      }
    }
  }
}

// MARK: Animations

extension TutorialController {
  public func addAnimations(animations: [Animation], forPage page: Int) {
    for animation in animations {
      addAnimation(animation, forPage: page)
    }
  }

  public func addAnimation(animation: Animation, forPage page: Int) {
    if animations[page] == nil && page >= 0 && page < slides.count {
      animations[page] = []
    }
    animations[page]?.append(animation)
  }
}

extension TutorialController: PagesControllerDelegate {

  public func pageViewController(pageViewController: UIPageViewController,
    setViewController viewController: UIViewController, atPage page: Int) {
      animationIndex = page
      scrollView?.delegate = self
  }
}

extension TutorialController: UIScrollViewDelegate {

  public func scrollViewDidScroll(scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.x - CGRectGetWidth(view.frame)
    let offsetRatio = offset / CGRectGetWidth(view.frame)

    let pageCount = presentationCountForPageViewController(self)

    var index = animationIndex
    if (offsetRatio > 0.0 && index < pageCount - 1) ||
      (index == 0)  {
        index++
    }

    let canMove = offsetRatio != 0.0 &&
      !(animationIndex == 0 && offsetRatio < 0.0) &&
      !(animationIndex == pageCount - 1 && offsetRatio > 0.0)

    if canMove {
      animateAtIndex(index, perform: { animation in
        animation.moveWith(offsetRatio)
      })
    }
  }
}
