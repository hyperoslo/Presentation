import UIKit

let TutorialPageControlHeight: CGFloat = 37.0

@objc(HYP) public class TutorialViewController : UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

  lazy var pages: Array<UIViewController> = {
    return []
  }()

  var currentIndex: Int = 0

  public override func viewDidLoad() {
    super.viewDidLoad()

    self.delegate = self
    self.dataSource = self
  }

  public func addPage(viewController: UIViewController) {
    self.pages.insert(viewController, atIndex: self.pages.count)

    if self.pages.count == 1 {
      self.setViewControllers([viewController], direction: .Forward, animated: true, completion: nil)
    }
  }

  // MARK: UIPageViewControllerDataSource

  public func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    var index = viewControllerIndex(viewController)
    if index == 0 {
      return nil
    } else {
      index--
      return self.viewControllerAtIndex(index)
    }
  }

  public func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    var index = viewControllerIndex(viewController)

    index++

    if index == self.pages.count {
      return nil
    } else {
      return self.viewControllerAtIndex(index)
    }
  }

  public func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return self.pages.count
  }

  public func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    return 0
  }

  // MARK: UIPageViewControllerDelegate

  public func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [AnyObject]) {

  }

  public func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
    let viewControllers: NSArray = self.pages

    self.currentIndex = 1
  }

  // MARK: Private methods

  func viewControllerIndex(viewController: UIViewController) -> Int {
    let viewControllers: NSArray = self.pages

    return viewControllers.indexOfObject(viewController)
  }

  func viewControllerAtIndex(index: NSInteger) -> UIViewController {
    return self.pages[index]
  }

}
