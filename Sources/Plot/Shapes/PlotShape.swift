import SwiftUI

struct PlotShape: Shape {
  
  var f: (Double) -> Double
  var range: ClosedRange<Double>
  var step: Double.Stride
  
  init(
    _ f: @escaping (Double) -> Double,
    in range: ClosedRange<Double>,
    step: Double.Stride = 1.0
  ) {
    self.f = f
    self.range = range
    self.step = step
  }
  
  private var values: [Double] {
    var result = [Double]()
    for x in stride(from: range.lowerBound, to: range.upperBound, by: step) {
      result.append(f(x))
    }
    return result
  }
  
  private var ratios: [Double] {
    let min = values.min() ?? 0
    let max = values.max() ?? 1
    let step = max - min
    return values.map {
      ($0 - min) / step
    }
  }
  
  private var unitPoints: [UnitPoint] {
    let stepX = values.count > 1 ? 1.0 / CGFloat(values.count - 1) : 1.0
    return ratios.enumerated().map { (index, dataPoint) in
      UnitPoint(
        x: stepX * CGFloat(index),
        y: CGFloat(dataPoint)
      )
    }
  }
  
  func path(in rect: CGRect) -> Path {
    Path { path in
      path.addLines(unitPoints.points(in: rect))
    }
  }
}

private extension CGPoint {
  init(unitPoint: UnitPoint, in rect: CGRect) {
    self.init(
      x: rect.width * unitPoint.x,
      y: rect.height - (rect.height * unitPoint.y)
    )
  }
}

private extension Collection where Element == UnitPoint {
  func points(in rect: CGRect) -> [CGPoint] {
    map { .init(unitPoint: $0, in: rect) }
  }
}
