// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "swift-plot",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15)
  ],
  products: [
    .library(name: "Plot", targets: ["Plot"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "Plot",
      dependencies: []
    ),
    .testTarget(
      name: "swift-plotTests",
      dependencies: ["Plot"]
    ),
  ]
)
