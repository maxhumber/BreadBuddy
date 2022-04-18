// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "BreadKit",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "BreadKit", targets: ["BreadKit"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "BreadKit", dependencies: []),
        .testTarget(name: "BreadKitTests", dependencies: ["BreadKit"]),
    ]
)
