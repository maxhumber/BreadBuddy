// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "CustomUI",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "CustomUI", targets: ["CustomUI"])
    ],
    dependencies: [],
    targets: [
        .target(name: "CustomUI", dependencies: []),
        .testTarget(name: "CustomUITests", dependencies: ["CustomUI"])
    ]
)
