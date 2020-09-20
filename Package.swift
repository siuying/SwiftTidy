// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftTidy",
    products: [
        .library(name: "SwiftTidy", targets: ["SwiftTidy"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(name: "SwiftTidy", dependencies: ["CTidy"]),
        .target(name: "CTidy", dependencies: []),
        .testTarget(name: "SwiftTidyTests", dependencies: ["SwiftTidy"]),
    ]
)
