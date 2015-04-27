@import UIKit;

typedef NS_ENUM(NSInteger, HorizontalMarginType) {
  HorizontalMarginTypeLeft,
  HorizontalMarginTypeRight
};

typedef NS_ENUM(NSInteger, VerticalMarginType) {
  VerticalMarginTypeTop,
  VerticalMarginTypeBottom
};

struct TutorialViewPosition
{
  CGFloat xPercentage;
  CGFloat yPercentage;
  HorizontalMarginType hMargin;
  VerticalMarginType vMargin;
};
