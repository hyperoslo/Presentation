//
//  SlideViewController.swift
//  Pods
//
//  Created by Vadym Markov on 01/05/15.
//
//

import UIKit

public class SlideController: UIViewController {

  private var contents = [Content]()
  private var animations = [Animation]()

  public convenience init(contents: [Content]) {
    self.init()

    addContents(contents)
  }

  // MARK: View lifecycle

  public override func viewDidLoad() {
    super.viewDidLoad()
  }

  public override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
  }

  override public func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
  }

  public override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    for content in contents {
      content.layout()
    }

    for animation in animations {
      animation.play()
    }
  }

  // MARK: device orientation

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

// MARK: Public methods

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

  public func addAnimations(animations: [Animation]) {
    for animation in animations {
      addAnimation(animation)
    }
  }

  public func addAnimation(animation: Animation) {
    animations.append(animation)
  }
}
