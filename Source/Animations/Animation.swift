import UIKit

public protocol Animation {

  func play()
  func playBack()
  func moveWith(offsetRatio: CGFloat)
}
