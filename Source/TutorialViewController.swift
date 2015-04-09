import UIKit

let TutorialPageControlHeight: CGFloat = 37.0


public class TutorialViewController : UIViewController,UIScrollViewDelegate {

    let TutorialDeviceRotatedNotification = "deviceDidRotate"

    private var scrollView: UIScrollView = {
        let bounds = UIScreen.mainScreen().bounds
        let frame = CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height)
        let scrollView = UIScrollView(frame: bounds)

        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight

        return scrollView
    }()

    private var pageControl: UIPageControl  = {
        let bounds = UIScreen.mainScreen().bounds
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
        let bounds = UIScreen.mainScreen().bounds

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
        let bounds = UIScreen.mainScreen().bounds
        var index = 0
        for obj in self.view.subviews {
            var view = obj as! UIView
            var frame = view.frame
            frame.size.width = bounds.size.width
            frame.size.height = bounds.size.height

            view.frame = frame

            ++index
        }
    }
}
