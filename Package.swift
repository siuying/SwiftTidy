// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftTidy",
    products: [
        .library(name: "SwiftTidy", targets: ["SwiftTidy"]),
    ],
    targets: [
        .target(name: "SwiftTidy", dependencies: ["CTidy"]),
        .binaryTarget(
            name: "CTidy",
            path: "vendor/Tidy.xcframework"
        ),
        .testTarget(name: "SwiftTidyTests", dependencies: ["SwiftTidy"]),
    ]
)
