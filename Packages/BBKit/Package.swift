// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "BBKit",
    products: [
        .library(name: "BBKit", targets: ["BBKit"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "BBKit", dependencies: []),
        .testTarget(name: "BBKitTests", dependencies: ["BBKit"]),
    ]
)
