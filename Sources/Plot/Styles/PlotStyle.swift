import SwiftUI

public struct PlotStyle: Equatable {
  
  public var lineWidth: CGFloat
  public var color: Color?
  
  public init(lineWidth: CGFloat = 1.0, color: Color? = nil) {
    self.lineWidth = lineWidth
    self.color = color
  }
  
  public static let `default` = Self.init(lineWidth: 1.0, color: .blue)
}

private struct PlotStyleKey: EnvironmentKey {
  
  static var defaultValue: PlotStyle = .default
}

extension EnvironmentValues {
  
  public var plotStyle: PlotStyle {
    get { self[PlotStyleKey.self] }
    set { self[PlotStyleKey.self] = newValue }
  }
}

extension View {
  
  public func plotStyle(_ style: PlotStyle) -> some View {
    self.environment(\.plotStyle, style)
  }
}
