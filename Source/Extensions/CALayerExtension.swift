extension CALayer {

  func pauseLayer() {
    let pausedTime = convertTime(CACurrentMediaTime(), fromLayer:nil)
    speed = 0.0
    timeOffset = pausedTime
  }

  func resumeLayer() {
    let pausedTime = timeOffset
    speed = 1.0
    timeOffset = 0.0
    beginTime = 0.0
    let timeSincePause = convertTime(CACurrentMediaTime(), fromLayer:nil) - pausedTime
    beginTime = timeSincePause
  }
}
