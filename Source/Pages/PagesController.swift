import UIKit

@objc(HYPPagesControllerDelegate) public protocol PagesControllerDelegate {
  func pageViewController(_ pageViewController: UIPageViewController,
                          setViewController viewController: UIViewController,
                          atPage page: Int)
}

@objc(HYPPagesController) open class PagesController: UIPageViewController {
  private struct Dimensions {
    static let bottomLineHeight: CGFloat = 1.0
    static let bottomLineSideMargin: CGFloat = 40.0
    static let bottomLineBottomMargin: CGFloat = 36.0
  }

  public let startPage = 0
  @objc public var setNavigationTitle = true

  public var enableSwipe = true {
    didSet {
      toggle()
    }
  }

  public var showBottomLine = false {
    didSet {
      bottomLineView.isHidden = !showBottomLine
    }
  }

  public var showPageControl = true
  private lazy var pages = Array<UIViewController>()

  public var pagesCount: Int {
    return pages.count
  }

  @objc public private(set) var currentIndex = 0
  public weak var pagesDelegate: PagesControllerDelegate?

  public private(set) lazy var bottomLineView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.white
    view.alpha = 0.4
    view.isHidden = true
    return view
  }()

  public private(set) var pageControl: UIPageControl?

  public convenience init(_ pages: [UIViewController],
                          transitionStyle: UIPageViewControllerTransitionStyle = .scroll,
                          navigationOrientation: UIPageViewControllerNavigationOrientation = .horizontal,
                          options: [String : AnyObject]? = nil) {
    self.init(
      transitionStyle: transitionStyle,
      navigationOrientation: navigationOrientation,
      options: options
    )

    add(pages)
  }

  open override func viewDidLoad() {
    super.viewDidLoad()

    delegate = self
    dataSource = self

    view.addSubview(bottomLineView)
    addConstraints()
    view.bringSubview(toFront: bottomLineView)
    goTo(startPage)
  }

  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    for subview in view.subviews {
      if subview is UIPageControl {
        pageControl = subview as? UIPageControl
      }
    }
  }

  // MARK: - Public methods

  open func goTo(_ index: Int) {
    if index >= 0 && index < pages.count {
      let direction: UIPageViewControllerNavigationDirection = (index > currentIndex) ? .forward : .reverse
      let viewController = pages[index]
      currentIndex = index

      setViewControllers(
        [viewController],
        direction: direction,
        animated: true,
        completion: { [unowned self] finished in
          self.pagesDelegate?.pageViewController(
            self,
            setViewController: viewController,
            atPage: self.currentIndex
          )
      })

      if setNavigationTitle {
        title = viewController.title
      }
    }
  }

  @objc open func moveForward() {
    goTo(currentIndex + 1)
  }

  @objc open func moveBack() {
    goTo(currentIndex - 1)
  }

    @objc dynamic open func add(_ viewControllers: [UIViewController]) {
    for viewController in viewControllers {
      addViewController(viewController)
    }
  }
}

// MARK: - UIPageViewControllerDataSource

extension PagesController: UIPageViewControllerDataSource {
  @objc open func pageViewController(_ pageViewController: UIPageViewController,
                                     viewControllerBefore viewController: UIViewController) -> UIViewController? {
    let index = prevIndex(viewControllerIndex(viewController))
    return pages.at(index)
  }

  @objc open func pageViewController(_ pageViewController: UIPageViewController,
                                     viewControllerAfter viewController: UIViewController) -> UIViewController? {
    let index: Int? = nextIndex(viewControllerIndex(viewController))
    return pages.at(index)
  }

  @objc open func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return showPageControl ? pages.count : 0
  }

  @objc open func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return showPageControl ? currentIndex : 0
  }
}

// MARK: - UIPageViewControllerDelegate

extension PagesController: UIPageViewControllerDelegate {
  @objc open func pageViewController(_ pageViewController: UIPageViewController,
                                     didFinishAnimating finished: Bool,
                                     previousViewControllers: [UIViewController],
                                     transitionCompleted completed: Bool) {
    guard completed else {
      return
    }

    guard let viewController = pageViewController.viewControllers?.last else {
      return
    }

    guard let index = viewControllerIndex(viewController) else {
      return
    }

    currentIndex = index

    if setNavigationTitle {
      title = viewController.title
    }

    if let pageControl = pageControl {
      pageControl.currentPage = currentIndex
    }

    pagesDelegate?.pageViewController(self, setViewController: pages[currentIndex], atPage: currentIndex)
  }
}

// MARK: - Private methods

private extension PagesController {
  func viewControllerIndex(_ viewController: UIViewController) -> Int? {
    return pages.index(of: viewController)
  }

  func toggle() {
    for subview in view.subviews {
      if let subview = subview as? UIScrollView {
        subview.isScrollEnabled = enableSwipe
        break
      }
    }
  }

  func addViewController(_ viewController: UIViewController) {
    pages.append(viewController)

    if pages.count == 1 {
      setViewControllers([viewController],
        direction: .forward,
        animated: true,
        completion: { [unowned self] finished in
          self.pagesDelegate?.pageViewController(self,
            setViewController: viewController,
            atPage: self.currentIndex)
        })
      if setNavigationTitle {
        title = viewController.title
      }
    }
  }

  func addConstraints() {
    view.addConstraint(NSLayoutConstraint(item: bottomLineView, attribute: .bottom,
      relatedBy: .equal, toItem: view, attribute: .bottom,
      multiplier: 1, constant: -Dimensions.bottomLineBottomMargin))

    view.addConstraint(NSLayoutConstraint(item: bottomLineView, attribute: .left,
      relatedBy: .equal, toItem: view, attribute: .left,
      multiplier: 1, constant: Dimensions.bottomLineSideMargin))

    view.addConstraint(NSLayoutConstraint(item: bottomLineView, attribute: .right,
      relatedBy: .equal, toItem: view, attribute: .right,
      multiplier: 1, constant: -Dimensions.bottomLineSideMargin))

    view.addConstraint(NSLayoutConstraint(item: bottomLineView, attribute: .height,
      relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,
      multiplier: 1, constant: Dimensions.bottomLineHeight))
  }
}

// MARK: - Storyboard

extension PagesController {
  public convenience init(_ storyboardIds: [String], storyboard: UIStoryboard = .Main) {
    let pages = storyboardIds.map(storyboard.instantiateViewController(withIdentifier:))
    self.init(pages)
  }
}
