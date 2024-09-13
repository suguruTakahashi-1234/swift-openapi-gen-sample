// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftOpenAPIGenCLIPackage",
    dependencies: [
        .package(url: "https://github.com/apple/swift-openapi-generator.git", from: "1.3.0"),
    ]
)
