import UIKit
import Pages
import Hex

public class TutorialController: PagesController {

  private var backLayer = [BackViewModel]()
  private var animationLayer = [Int: [Animation]]()
  private var animationIndex = -1

  private weak var scrollView: UIScrollView?

  public convenience init(pages: [UIViewController],
    backViewModels: [BackViewModel] = []) {
    self.init(
      transitionStyle: .Scroll,
      navigationOrientation: .Horizontal,
      options: nil)

    add(pages)
    addBackViewModels(backViewModels)
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
  }

  override public func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)

    NSNotificationCenter.defaultCenter().removeObserver(
      self,
      name: UIDeviceOrientationDidChangeNotification,
      object: nil)
  }

  override public func add(viewControllers: [UIViewController]) {
    super.add(viewControllers)
  }

  public override func goTo(index: Int) {
    let pageCount = presentationCountForPageViewController(self)
    let disableScroll = animationIndex != -1

    if index >= 0 && index < pageCount {
      let reverse = index < animationIndex
      if !reverse {
        animationIndex = index
      }

      if let animations = animationLayer[animationIndex] {
        for animation in animations {
          checkAnimation(animation)

          if disableScroll {
            scrollView?.delegate = nil
          }

          if reverse {
            animation.playBack()
          } else {
            animation.play()
          }
        }
      }
    }

    super.goTo(index)
  }

  // MARK: device orientation

  func didRotate() {
    if let animations = animationLayer[animationIndex] {
      for animation in animations {
        animation.rotate()
      }
    }
    for backViewModel in backLayer {
      backViewModel.rotate()
    }
  }

}

// MARK: - Back layer

extension TutorialController {

  public func addBackViewModels(backViewModels: [BackViewModel]) {
    for backViewModel in backViewModels {
      addBackViewModel(backViewModel)
    }
  }

  public func addBackViewModel(backViewModel: BackViewModel) {
    backLayer.append(backViewModel)
    view.addSubview(backViewModel.view)
    view.sendSubviewToBack(backViewModel.view)
    backViewModel.place()
  }
}

// MARK: - Animation layer

extension TutorialController {

  public func addAnimations(animations: [Animation], forPage page: Int) {
    for animation in animations {
      addAnimation(animation, forPage: page)
    }
  }

  public func addAnimation(animation: Animation, forPage page: Int) {
    if animationLayer[page] == nil {
      animationLayer[page] = []
    }
    animationLayer[page]?.append(animation)
  }

  private func checkAnimation(animation: Animation) {
    if animation.view.superview == nil {
      view.addSubview(animation.view)
      view.sendSubviewToBack(animation.view)
    }
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
    if offsetRatio > 0.0 && index < pageCount - 1 {
      index++
    }

    if let animations = animationLayer[index] {
      for animation in animations {
        let canMove = offsetRatio != 0.0 &&
          !(animationIndex == 0 && offsetRatio < 0.0) &&
          !(animationIndex == pageCount - 1 && offsetRatio > 0.0)

        if canMove {
          checkAnimation(animation)
          animation.move(offsetRatio)
        }
      }
    }
  }
}
