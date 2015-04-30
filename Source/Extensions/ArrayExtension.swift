extension Array {

  func at(index: Int?) -> T? {
    if let index = index where index >= 0 && index < endIndex {
      return self[index]
    } else {
      return nil
    }
  }
}
