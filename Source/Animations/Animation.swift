import UIKit

public protocol Animation {

  func play()
  func playBack()
  func moveWith(offsetRatio: CGFloat)

  weak var content: Content! { get set }
}
