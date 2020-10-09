// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "TriforkSwiftLogger",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "TriforkSwiftLogger",
            targets: ["TriforkSwiftLogger"]),
    ],
    targets: [
        .target(
            name: "TriforkSwiftLogger",
            dependencies: []),
        .testTarget(
            name: "TriforkSwiftLoggerTests",
            dependencies: ["TriforkSwiftLogger"]),
    ]
)
