import UIKit

open class SlideController: UIViewController {
  private var contents = [Content]()
  private var animations = [Animatable]()
  private var visible = false

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

public extension SlideController {
  func add(contents: [Content]) {
    for content in contents {
      add(content: content)
    }
  }

  func add(content: Content) {
    contents.append(content)
    view.addSubview(content.view)
    content.layout()
  }

  func add(animations: [Animatable]) {
    for animation in animations {
      add(animation: animation)
    }
  }

  func add(animation: Animatable) {
    animations.append(animation)
  }
}
