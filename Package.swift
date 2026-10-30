// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "DJStudioCore",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "DJStudioCore", targets: ["DJStudioCore"])
    ],
    targets: [
        .target(name: "DJStudioCore"),
        .testTarget(name: "DJStudioCoreTests", dependencies: ["DJStudioCore"])
    ]
)
