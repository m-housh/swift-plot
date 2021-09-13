import SwiftUI

struct PlotShape: Shape {
  
  var proxy: PlotProxy
  
  func path(in rect: CGRect) -> Path {
    Path { path in
      path.addLines(proxy.unitPoints.points(in: rect))
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
