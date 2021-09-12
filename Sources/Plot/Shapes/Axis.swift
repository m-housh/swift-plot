import SwiftUI

struct Axis: Shape {
  func path(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: .init(x: 0, y: 0))
      path.addLine(to: .init(x: 0, y: rect.maxY))
      path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
    }
  }
}
