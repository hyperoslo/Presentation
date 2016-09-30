import UIKit

open class SlideController: UIViewController {

  fileprivate var contents = [Content]()
  fileprivate var animations = [Animatable]()
  fileprivate var visible = false

  public convenience init(contents: [Content]) {
    self.init()

    add(contents: contents)
  }

  // MARK: - View lifecycle

  open override func viewWillAppear(_ animated: Bool) {
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

  open override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

    visible = false
  }

  // MARK: - Navigation

  open func goToLeft() {
    for case let animation as TransitionAnimation in animations {
      animation.reflective = true
    }
  }

  open func goToRight() {
    for case let animation as TransitionAnimation in animations {
      animation.reflective = false
    }
  }
}

// MARK: - Public methods

extension SlideController {

  public func add(contents: [Content]) {
    for content in contents {
      add(content: content)
    }
  }

  public func add(content: Content) {
    contents.append(content)
    view.addSubview(content.view)

    content.layout()
  }

  public func add(animations: [Animatable]) {
    for animation in animations {
      add(animation: animation)
    }
  }

  public func add(animation: Animatable) {
    animations.append(animation)
  }
}
