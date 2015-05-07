import UIKit

public class SlideController: UIViewController {

  private var contents = [Content]()
  private var animations = [Animatable]()
  private var visible = false

  public convenience init(contents: [Content]) {
    self.init()

    addContents(contents)
  }

  // MARK: - View lifecycle

  public override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    if !visible {
      visible = true
      for content in contents {
        content.layout()
      }

      for animation in animations {
        animation.play()
      }
    }
  }

  public override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)

    visible = false
  }

  // MARK: - Navigation

  public func goToLeft() {
    for animation in animations {
      if animation is TransitionAnimation {
        (animation as! TransitionAnimation).reflective = true
      }
    }
  }

  public func goToRight() {
    for animation in animations {
      if animation is TransitionAnimation {
        (animation as! TransitionAnimation).reflective = false
      }
    }
  }
}

// MARK: - Public methods

extension SlideController {

  public func addContents(contents: [Content]) {
    for content in contents {
      addContent(content)
    }
  }

  public func addContent(content: Content) {
    contents.append(content)
    view.addSubview(content.view)

    content.layout()
  }

  public func addAnimations(animations: [Animatable]) {
    for animation in animations {
      addAnimation(animation)
    }
  }

  public func addAnimation(animation: Animatable) {
    animations.append(animation)
  }
}
