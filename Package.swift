// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "TriforkSwiftLogger",
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
