// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "Sugar",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Sugar", targets: ["Sugar"])
    ],
    dependencies: [],
    targets: [
        .target(name: "Sugar", dependencies: []),
    ]
)
