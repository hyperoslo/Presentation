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

  public override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    NSNotificationCenter.defaultCenter().addObserver(
      self,
      selector: "didRotate",
      name: UIDeviceOrientationDidChangeNotification,
      object: nil)
  }

  override public func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)

    NSNotificationCenter.defaultCenter().removeObserver(
      self,
      name: UIDeviceOrientationDidChangeNotification,
      object: nil)

    for animation in animations {
      animation.playBack()
    }
  }

  public override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    for animation in animations {
      animation.play()
    }
  }

  // MARK: device orientation

  func didRotate() {
    for content in contents {
      content.layout()
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
