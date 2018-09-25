extension Array {
  func at(_ index: Int?) -> Element? {
    if let index = index , index >= 0 && index < endIndex {
      return self[index]
    } else {
      return nil
    }
  }
}

func nextIndex(_ x: Int?) -> Int? {
  return ((x)! + 1)
}

func prevIndex(_ x: Int?) -> Int? {
  return ((x)! - 1)
}
