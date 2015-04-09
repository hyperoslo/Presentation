import UIKit

let TutorialPageControlHeight: CGFloat = 37.0

public class TutorialViewController : UIViewController,UIScrollViewDelegate {

    private var scrollView: UIScrollView = {
        let bounds = UIScreen.mainScreen().bounds
        let frame = CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height)
        let scrollView = UIScrollView(frame: bounds)

        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false

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
        self.view.addSubview(self.pageControl)
    }

    // UIScrollViewDelegate

    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width

        self.pageControl.currentPage = Int(index)
    }

    // Public methods

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

    // Private methods

}
