import SwiftUI

struct Ticks: Shape {
  
  var proxy: PlotProxy

  func path(in rect: CGRect) -> Path {
    Path { path in
      // Y Ticks
      path.move(to: .init(x: 0, y: 0))
      path.addLine(to: .init(x: 10, y: 0))
      let yStep = rect.height / CGFloat(proxy.data.count)
      for index in 1...proxy.data.count {
        let y = rect.height - (CGFloat(index) * yStep)
        path.move(to: .init(x: 0, y: y))
        path.addLine(to: .init(x: 10, y: y))
      }
      
      // X Ticks
      for index in 1..<proxy.data.count {
        let x = rect.width * (CGFloat(index) * proxy.xStep)
        path.move(to: .init(x: x, y: rect.maxY))
        path.addLine(to: .init(x: x, y: rect.maxY - 10))
      }
    }
  }
}
