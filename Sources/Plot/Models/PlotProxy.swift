import SwiftUI

struct PlotProxy: Equatable {
  
  private(set) var data: [Double]
  private(set) var dataRatios: [Double]
  
  init(
    _ f: @escaping (Double) -> Double,
    in range: ClosedRange<Double>,
    step: Double.Stride = 1.0
  ) {
    self.data = Self.makeData(f, in: range, step: step)
    self.dataRatios = Self.makeRatios(self.data)
  }
  
  private static func makeData(
    _ f: @escaping (Double) -> Double,
    in range: ClosedRange<Double>,
    step: Double.Stride = 1.0
  ) -> [Double] {
    var values = [Double]()
    for x in stride(from: range.lowerBound, to: range.upperBound, by: step) {
      values.append(f(x))
    }
    return values
  }
  
  private static func makeRatios(_ data: [Double]) -> [Double] {
    let min = data.min() ?? 0
    let max = data.max() ?? 1
    let step = max - min
    return data.map { ($0 - min) / step}
  }
}

extension PlotProxy {
  
  var xStep: CGFloat {
    data.count > 1
      ? 1.0 / CGFloat(data.count - 1)
      : 1.0
  }
  
  func unitPoint(at index: Int) -> UnitPoint {
    .init(
      x: xStep * CGFloat(index),
      y: CGFloat(dataRatios[index])
    )
  }
  
  var unitPoints: [UnitPoint] {
    (0..<dataRatios.count)
      .map(unitPoint(at:))
  }
}
