import UIKit
import Pages
import Hex

public class TutorialController: PagesController {

  private var backLayer = [UIView]()
  private var animationLayer = [Int: [TutorialAnimation]]()
  private var animationIndex = 0

  convenience init(pages: [UIViewController], backViews: [UIView] = []) {
    self.init(
      transitionStyle: .Scroll,
      navigationOrientation: .Horizontal,
      options: nil)

    add(pages)
    addViewsToBack(backViews)

    pagesDelegate = self
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
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
  }
}

// MARK: - Back layer

extension TutorialController {

  public func addViewsToBack(backViews: [UIView]) {
    for backView in backViews {
      addViewToBack(backView)
    }
  }

  public func addViewToBack(backView: UIView) {
    backLayer.append(backView)
    view.addSubview(backView)
    view.sendSubviewToBack(backView)
  }
}

// MARK: - Animation layer

extension TutorialController {

  public func addAnimation(animation: TutorialAnimation, forPage page: Int) {
    if animationLayer[page] == nil {
      animationLayer[page] = []
    }
    animationLayer[page]?.append(animation)
  }

  func playAnimations() {
    println("Play :\(animationIndex)")
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
    println("Playback :\(animationIndex)")
    if let animations = animationLayer[animationIndex] {
      for animation in animations {
        animation.playBack()
      }
    }
  }
}

extension TutorialController: PagesControllerDelegate {

  public func pageViewController(pageViewController: UIPageViewController, setViewController viewController: UIViewController, atPage page: Int) {
    println("Hoho")
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

public extension UIViewController {

  convenience init(model: TutorialModel) {
    self.init(nibName: nil, bundle: nil)

    addViewsFromModel(model)
  }

  func addViewsFromModel(model: TutorialModel) {
    let modelViews = model.views()

    for modelView in modelViews {
      view.addSubview(modelView)
    }

    model.layoutSubviews()
  }
}
