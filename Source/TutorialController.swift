import UIKit
import Pages
import Hex

public class TutorialController: PagesController {

  private var backLayer = [BackViewModel]()
  private var animationLayer = [Int: [Animation]]()
  private var animationIndex = 0

  convenience init(pages: [UIViewController],
    backViewModels: [BackViewModel] = []) {
    self.init(
      transitionStyle: .Scroll,
      navigationOrientation: .Horizontal,
      options: nil)

    add(pages)
    addBackViewModels(backViewModels)

    pagesDelegate = self
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    for backViewModel in backLayer {
      backViewModel.place()
    }
  }

  public override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    NSNotificationCenter.defaultCenter().addObserver(
      self,
      selector: "didRotate",
      name: UIDeviceOrientationDidChangeNotification,
      object: nil)

    animationIndex = 0

    for subview in view.subviews{
      if subview.isKindOfClass(UIScrollView){
        (subview as! UIScrollView).delegate = self
      }
    }
    playAnimations()
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
    if index > animationIndex {
      animationIndex++
      playAnimations()
    } else {
      playBackAnimations()
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

  func playAnimations() {
    if let animations = animationLayer[animationIndex] {
      for animation in animations {
        if animation.view.superview == nil {
          view.addSubview(animation.view)
          view.sendSubviewToBack(animation.view)
          animation.show?()
        }

        animation.play()
      }
    }
  }

  func playBackAnimations() {
    if let animations = animationLayer[animationIndex] {
      for animation in animations {
        animation.playBack()
      }
    }
  }
}

extension TutorialController: PagesControllerDelegate {

  public func pageViewController(pageViewController: UIPageViewController, setViewController viewController: UIViewController, atPage page: Int) {
    animationIndex = page
  }
}

extension TutorialController: UIScrollViewDelegate {

  public func scrollViewDidScroll(scrollView: UIScrollView) {
    let offsetRatio = (scrollView.contentOffset.x - CGRectGetWidth(view.frame)) / CGRectGetWidth(view.frame)

    let pageCount = presentationCountForPageViewController(self)

    var index = animationIndex
    if offsetRatio > 0.0 && index < pageCount - 1 {
      index++
    }

    if let animations = animationLayer[index] {
      for animation in animations {
        animation.move(offsetRatio)
      }
    }
  }
}
