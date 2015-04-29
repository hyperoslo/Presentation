import UIKit

@objc public protocol Animation {

  func play()
  func playBack()
  func move(offsetRatio: CGFloat)
  func rotate()

  var view: UIView { get }
}
