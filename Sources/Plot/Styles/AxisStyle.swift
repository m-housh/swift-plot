import SwiftUI

public struct AxisStyle: Equatable {
  
  public var lineWidth: CGFloat
  public var color: Color?
  
  public init(
    lineWidth: CGFloat = 1.0,
    color: Color? = nil
  ) {
    self.lineWidth = lineWidth
    self.color = color
  }
  
  public static var `default`: Self { .init(lineWidth: 1.0, color: .gray )}
}

private struct AxisStyleKey: EnvironmentKey {
  static var defaultValue: AxisStyle?  = nil
}

extension EnvironmentValues {
  public var axisStyle: AxisStyle? {
    get { self[AxisStyleKey.self] }
    set { self[AxisStyleKey.self] = newValue }
  }
}

extension View {
  
  public func axis(_ style: AxisStyle? = nil) -> some View {
    self.environment(\.axisStyle, style)
  }
}
