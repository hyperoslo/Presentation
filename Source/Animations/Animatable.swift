import UIKit

@objc public protocol Animatable {

  func play()
  func playBack()
  func moveWith(offsetRatio: CGFloat)
}
