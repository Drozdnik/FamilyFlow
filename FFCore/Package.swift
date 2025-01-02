// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FFCore",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "FFCore", targets: ["FFCore"])
    ],
    targets: [
        .target(name: "FFCore", path: "Sources")
    ]
)
