import UIKit

public class TutorialViewController : UIViewController,UIScrollViewDelegate {

    let tutorialPageControlHeight: CGFloat = 37.0

    var scrollView: UIScrollView {
        let bounds = UIScreen.mainScreen().bounds
        let frame = CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height)
        let scrollView = UIScrollView(frame: bounds)

        scrollView.delegate = self
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false

        return scrollView
    }

    var pageControl: UIPageControl {
        let bounds = UIScreen.mainScreen().bounds
        let frame = CGRectMake(bounds.size.width / 4,
            bounds.size.height / 1.5,
            bounds.size.width / 2,
            tutorialPageControlHeight);
        let pageControl = UIPageControl(frame: frame)

        pageControl.currentPageIndicatorTintColor = UIColor.blueColor()
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()

        return pageControl
    }

    convenience init(title :String) {
        self.init()

        self.title = title
    }

    // MARK: View life cycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor.lightGrayColor()

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

    }

    // Private methods

}
