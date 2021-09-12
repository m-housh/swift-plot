import SwiftUI

struct Ticks: Shape {
  
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
  
  func path(in rect: CGRect) -> Path {
    Path { path in
      // Y Ticks
      path.move(to: .init(x: 0, y: 0))
      path.addLine(to: .init(x: 10, y: 0))
      let yStep = rect.height / CGFloat(values.count)
      for index in 1...values.count {
        let y = rect.height - (CGFloat(index) * yStep)
        path.move(to: .init(x: 0, y: y))
        path.addLine(to: .init(x: 10, y: y))
      }
      
      // X Ticks
//      path.move(to: .init(x: 0, y: rect.maxY))
      let xStep = values.count > 1 ? 1.0 / CGFloat(values.count - 1) : 1.0
      for index in 1..<values.count {
        let x = rect.width * (CGFloat(index) * xStep)
        path.move(to: .init(x: x, y: rect.maxY))
        path.addLine(to: .init(x: x, y: rect.maxY - 10))
      }
    }
  }
}
