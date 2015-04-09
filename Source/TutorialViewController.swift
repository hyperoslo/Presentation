import UIKit

let TutorialPageControlHeight: CGFloat = 37.0

public class TutorialViewController : UIViewController,UIScrollViewDelegate {

    let TutorialDeviceRotatedNotification = "deviceDidRotate"

    private var scrollView: UIScrollView = {
        let bounds = UIScreen.mainScreen().liveBounds()
        let frame = CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height)
        let scrollView = UIScrollView(frame: bounds)

        scrollView.backgroundColor = UIColor.redColor()
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight

        return scrollView
    }()

    private var pageControl: UIPageControl  = {
        let bounds = UIScreen.mainScreen().liveBounds()
        let frame = CGRectMake(bounds.size.width / 4,
            bounds.size.height / 1.5,
            bounds.size.width / 2,
            TutorialPageControlHeight);
        let pageControl = UIPageControl(frame: frame)

        pageControl.currentPageIndicatorTintColor = UIColor.blueColor()
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.setTranslatesAutoresizingMaskIntoConstraints(false)

        return pageControl
    }()

    public var currentPage: Int = 0 {
        didSet { self.scrollToPageWithIndex(currentPage) }
    }

    convenience init(title :String) {
        self.init()

        self.title = title
    }

    // MARK: View life cycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor.whiteColor()

        self.scrollView.delegate = self

        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.pageControl)
    }

    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: NSSelectorFromString(TutorialDeviceRotatedNotification),
            name: UIDeviceOrientationDidChangeNotification,
            object: nil)
    }

    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        NSNotificationCenter.removeObserver(self, forKeyPath: TutorialDeviceRotatedNotification)
    }

    // MARK: UIScrollViewDelegate

    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width

        self.pageControl.currentPage = Int(index)
    }

    // MARK: Public methods

    public func addPage(view: UIView) {
        let bounds = UIScreen.mainScreen().liveBounds()

        self.scrollView.contentSize = CGSizeMake(
            self.scrollView.contentSize.width + self.scrollView.bounds.size.width,
            self.scrollView.contentSize.height);
        view.frame = CGRectMake(
            self.scrollView.contentSize.width - self.scrollView.bounds.size.width,
            0,
            bounds.size.width,
            bounds.size.height);

        self.scrollView.addSubview(view)

        self.pageControl.numberOfPages += 1;
    }

    // MARK: Private methods

    func deviceDidRotate() {
        self.invalidateLayout()
    }

    private func invalidateLayout() {
        let bounds = UIScreen.mainScreen().liveBounds()
        var index = 0
        var heightOffset: CGFloat = 0.0

        if let navigationBar = self.navigationController?.navigationBar {
            heightOffset += navigationBar.frame.origin.y
            heightOffset += navigationBar.frame.size.height
        }

        for subView in self.scrollView.subviews {
            var view = subView as! UIView
            var frame = view.frame

            if index > 0 {
                frame.origin.x = bounds.size.width * CGFloat(index)
            }

            frame.size.width = bounds.size.width
            frame.size.height = self.scrollView.frame.size.height
            view.frame = frame
            ++index
        }

        self.scrollView.contentSize = CGSizeMake(
            bounds.size.width * CGFloat(index - 1),
            bounds.size.height - heightOffset
        );

        self.scrollToPageWithIndex(self.pageControl.currentPage)
    }

    private func scrollToPageWithIndex(pageIndex: Int) {
        let bounds = UIScreen.mainScreen().liveBounds()
        let view = self.scrollView.subviews[pageIndex] as! UIView
        self.scrollView.scrollRectToVisible(view.frame, animated: true)
    }
}
