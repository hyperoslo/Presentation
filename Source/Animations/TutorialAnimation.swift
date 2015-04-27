import UIKit

@objc public protocol TutorialAnimation {

  func play()
  func playBack()
  func move(offsetRatio: CGFloat)
  var view: UIView { get }
  var isPlaying: Bool { get }
  
  optional func show()
}
