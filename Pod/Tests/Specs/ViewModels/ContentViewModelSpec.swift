import Quick
import Nimble
import Tutorial

class ContentViewModelSpec: QuickSpec {

  struct Dimensions {
    static let minimumMarginSpace: CGFloat = 20.0
  }

  override func spec() {
    describe("ContentViewModel") {
      var model: ContentViewModel!

      beforeEach {
        model = ContentViewModel(
          title: "Step I",
          text: "Collect underpants",
          image: SpecHelper.image())
      }

      describe("#init") {
        it("sets title to titleLabel") {
          expect(model.titleLabel.text).to(equal(model.title))
        }

        it("sets text to textView") {
          expect(model.textView.text).to(equal(model.text))
        }

        it("sets image to imageView") {
          expect(model.imageView.image).to(equal(model.image))
        }
      }

      describe("#setTitleAttributes") {
         it("sets attributes to titleLabel") {
          let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(14.0)]
          let string = NSAttributedString(string: model.title!, attributes: attributes)

          model.setTitleAttributes(attributes)
          expect(model.titleLabel.attributedText).to(equal(string))
        }
      }

      describe("#setTextAttributes") {
        it("sets attributes to textView") {
          let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(14.0)]
          let string = NSAttributedString(string: model.text!, attributes: attributes)

          model.setTextAttributes(attributes)
          expect(model.textView.attributedText).to(equal(string))
        }
      }

      describe("#views") {
        var views: [UIView]!

        context("when we have title only") {
          beforeEach {
            model = ContentViewModel(
              title: "Step I",
              text: nil,
              image: nil)
            views = model.views()
          }

          it("returns titleLabel only") {
            expect(views.count).to(equal(1))
          }
        }

        context("when we have title and text") {
          beforeEach {
            model = ContentViewModel(
              title: "Step I",
              text: "Collect underpants",
              image: nil)
            views = model.views()
          }

          it("returns titleLabel and textView") {
            expect(views.count).to(equal(2))
          }
        }

        context("when we have title, text are image") {
          beforeEach {
            model = ContentViewModel(
              title: "Step I",
              text: "Collect underpants",
              image: SpecHelper.image())
            views = model.views()
          }

          it("returns titleLabel, textView and imageView") {
            expect(views.count).to(equal(3))
          }
        }
      }

      describe("#layoutSubviews") {
        var view: UIView!

        context("when we have title only") {
          beforeEach {
            model = ContentViewModel(
              title: "Step I",
              text: nil,
              image: nil)
            view = viewWithSubviewsFromModel(model)
          }

          it("moves titleLabel to the bottom of its superview") {
            expect(CGRectGetMaxY(model.titleLabel.frame)).to(equal(CGRectGetMaxY(view.frame)
              - Dimensions.minimumMarginSpace))
            expect(CGRectGetMinX(model.titleLabel.frame)).to(equal(CGRectGetMinX(view.frame)
              + Dimensions.minimumMarginSpace))
            expect(CGRectGetMaxX(model.titleLabel.frame)).to(equal(CGRectGetMaxX(view.frame)
              - Dimensions.minimumMarginSpace))
          }
        }

        context("when we have title and text") {
          beforeEach {
            model = ContentViewModel(
              title: "Step I",
              text: "Collect underpants",
              image: nil)
            view = viewWithSubviewsFromModel(model)
          }

          it("moves textView to the bottom of its superview") {
            expect(CGRectGetMaxY(model.textView.frame)).to(equal(CGRectGetMaxY(view.frame)
              - Dimensions.minimumMarginSpace))
            expect(CGRectGetMinX(model.textView.frame)).to(equal(CGRectGetMinX(view.frame)
              + Dimensions.minimumMarginSpace))
            expect(CGRectGetMaxX(model.textView.frame)).to(equal(CGRectGetMaxX(view.frame)
              - Dimensions.minimumMarginSpace))
          }

          it("places titleLabel above textView") {
            expect(CGRectGetMaxY(model.titleLabel.frame)).to(equal(CGRectGetMinY(model.textView.frame)
              - Dimensions.minimumMarginSpace))
            expect(CGRectGetMinX(model.titleLabel.frame)).to(equal(CGRectGetMinX(view.frame)
              + Dimensions.minimumMarginSpace))
            expect(CGRectGetMaxX(model.titleLabel.frame)).to(equal(CGRectGetMaxX(view.frame)
              - Dimensions.minimumMarginSpace))
          }
        }

        context("when we have title, text and image") {
          beforeEach {
            model = ContentViewModel(
              title: "Step I",
              text: "Collect underpants",
              image: SpecHelper.image())
            view = viewWithSubviewsFromModel(model)
          }

          it("moves textView to the bottom of its superview") {
            expect(CGRectGetMaxY(model.textView.frame)).to(equal(CGRectGetMaxY(view.frame)
              - Dimensions.minimumMarginSpace))
            expect(CGRectGetMinX(model.textView.frame)).to(equal(CGRectGetMinX(view.frame)
              + Dimensions.minimumMarginSpace))
            expect(CGRectGetMaxX(model.textView.frame)).to(equal(CGRectGetMaxX(view.frame)
              - Dimensions.minimumMarginSpace))
          }

          it("places titleLabel above textView") {
            expect(CGRectGetMaxY(model.titleLabel.frame)).to(equal(CGRectGetMinY(model.textView.frame)
              - Dimensions.minimumMarginSpace))
            expect(CGRectGetMinX(model.titleLabel.frame)).to(equal(CGRectGetMinX(view.frame)
              + Dimensions.minimumMarginSpace))
            expect(CGRectGetMaxX(model.titleLabel.frame)).to(equal(CGRectGetMaxX(view.frame)
              - Dimensions.minimumMarginSpace))
          }

          it("moves imageView to the center of its superview") {
            expect(CGRectGetMidX(model.imageView.frame)).to(equal(CGRectGetMidX(view.frame)))
            expect(CGRectGetMidY(model.imageView.frame)).to(equal(CGRectGetMidY(view.frame)))
          }
        }
      }
    }
  }
}

// MARK: Helpers

private func viewWithSubviewsFromModel(model: ContentViewModel) -> UIView {
  let frame = CGRect(x: 0, y: 0, width: 600, height: 600)
  let view = UIView(frame: frame)
  for modelView in model.views() {
    view.addSubview(modelView)
  }
  model.layoutSubviews()
  view.layoutIfNeeded()

  return view
}
