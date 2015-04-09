import UIKit

let TutorialPageControlHeight: CGFloat = 37.0

public class TutorialViewController : UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

  lazy var pages: Array<UIViewController> = {
    return []
  }()

  var currentPage: Int = 0

  public override func viewDidLoad() {
    super.viewDidLoad()

    self.delegate = self
    self.dataSource = self
  }

  public func addPage(viewController: UIViewController) {
    self.pages.append(viewController)

    if self.pages.count == 1 {
      self.setViewControllers([viewController], direction: .Forward, animated: true, completion: nil)
    }
  }

  // MARK: UIPageViewControllerDataSource

  public func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    let index = self.currentPage - 1
    return self.viewControllerAtIndex(index)
  }

  public func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    let index = self.currentPage + 1
    return self.viewControllerAtIndex(index)
  }

  public func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return self.pages.count
  }

  public func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    return self.currentPage
  }

  // MARK: UIPageViewControllerDelegate

  public func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [AnyObject]) {
    println("pendingViewControllers: \(pendingViewControllers)")
  }

  public func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
    let previousController = previousViewControllers.first as! UIViewController
    var index = 0
    for page in self.pages {
      if previousController.isEqual(page) {
        index++
        break
      }
      index++
    }
    self.currentPage = index

  }

  // MARK: Private methods

  func viewControllerAtIndex(index: NSInteger) -> UIViewController? {
    if (index > -1 && index < self.pages.count) {
      return self.pages[index]
    } else {
      return nil
    }
  }

}
