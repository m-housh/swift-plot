import SwiftUI

public struct Plot: View {
  
  
  @Environment(\.axisStyle) var axisStyle: AxisStyle?
  @Environment(\.plotStyle) var plotStyle: PlotStyle
  
  var f: (Double) -> Double
  var range: ClosedRange<Double>
  var step: Double.Stride
  
  public init(
    _ f: @escaping (Double) -> Double,
    in range: ClosedRange<Double>,
    step: Double.Stride = 1.0
  ) {
    self.f = f
    self.range = range
    self.step = step
  }
  
  public var body: some View {
    ZStack {
      if let axisStyle = axisStyle {
        Axis()
          .stroke(lineWidth: axisStyle.lineWidth)
          .foregroundColor(axisStyle.color)
          .frame(minWidth: 200, minHeight: 200)
        
        // Todo: Move to have it's own style.
        Ticks(f, in: range, step: step)
          .stroke(lineWidth: axisStyle.lineWidth * 0.5)
          .foregroundColor(axisStyle.color)
          .frame(minWidth: 200, minHeight: 200)
      }
      
      PlotShape(f, in: range, step: step)
        .stroke(lineWidth: plotStyle.lineWidth)
        .foregroundColor(plotStyle.color)
        .frame(minWidth: 200, minHeight: 200)
    }
  }
}

#if DEBUG
func densityOfWater(at temperature: Double) -> Double {
  62.56 +
    3.413 *
    pow(10, -4) *
    temperature -
    6.255 *
    pow(10, -5) *
    pow(temperature, 2)
}

struct Plot_Previews: PreviewProvider {
  
  private static var values: [Double] {
    var results = [Double]()
    for x in stride(from: 50.0, to: 250.0, by: 10.0) {
      results.append(densityOfWater(at: x))
    }
    return results
  }
  
  private static var formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    return formatter
  }()
  
  private static var maxString: String {
    formatter.string(for: values.max()!)!
  }
  
  private static var minString: String {
    formatter.string(for: values.min()!)!
  }

  static var previews: some View {
    VStack(spacing: 5) {
      Text("Density of Water")
        .font(.title)
        .padding(.bottom)
      
      HStack {
        Text("Density")
          .font(.callout)
        Spacer()
      }
      .frame(width: 450, height: nil, alignment: .leading)
      
      ZStack {
        VStack {
          Text(maxString)
            .rotationEffect(.degrees(-30))
          Spacer()
          Text(minString)
            .rotationEffect(.degrees(-30))
        }
        .frame(width: 400, height: 430, alignment: .leading)
        .offset(x: -75, y: 20)
        
        Plot(
          densityOfWater(at:),
          in: 50...250,
          step: 10
        )
          .axis(.init(lineWidth: 4, color: .gray))
          .plotStyle(.init(lineWidth: 4, color: .blue))
          .frame(width: 400, height: 400, alignment: .center)
      }
      
      HStack {
        Text("50")
          .rotationEffect(.degrees(60))
        Spacer()
        Text("Temperature")
          .font(.callout)
        Spacer()
        Text("250")
          .rotationEffect(.degrees(60))
      }
      .frame(width: 430, height: 400, alignment: .topTrailing)
      .offset(x: 20, y: 0)
    }
//    }
//    .frame(width: 350, height: 350, alignment: .center)
  }
}
#endif
