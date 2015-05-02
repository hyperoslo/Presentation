import UIKit

public protocol Animatable: NSObjectProtocol {

  func play()
  func playBack()
  func moveWith(offsetRatio: CGFloat)
}
