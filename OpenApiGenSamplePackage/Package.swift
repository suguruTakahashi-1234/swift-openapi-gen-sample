// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenApiGenSamplePackage",
    platforms: [
        .iOS(.v17),
        .macOS(.v14), // use swift-openapi-generator CLI
    ],
    products: [
        .library(name: "OpenApiGenSamplePackage", targets: ["OpenApiGenSamplePackage"]),
    ],
    dependencies: [
        // swift-openapi-generator
        .package(url: "https://github.com/apple/swift-openapi-generator.git", from: "1.3.0"), // CLI Only
        .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.2"), // Use URLSession
        .package(url: "https://github.com/swift-server/swift-openapi-async-http-client", from: "1.0.0"), // Use AsyncHTTPClient

        // toast
        .package(url: "https://github.com/sanzaru/SimpleToast.git", from: "0.8.1"),
        
        // shimmer animation
        .package(url: "https://github.com/markiv/SwiftUI-Shimmer.git", from: "1.5.1"),
        
    ],
    targets: [
        .target(
            name: "OpenApiGenSamplePackage",
            dependencies: [
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
                .product(name: "OpenAPIAsyncHTTPClient", package: "swift-openapi-async-http-client"),
                .product(name: "SimpleToast", package: "SimpleToast"),
                .product(name: "Shimmer", package: "SwiftUI-Shimmer"),
            ]
        ),
        .testTarget(
            name: "OpenApiGenSamplePackageTests",
            dependencies: ["OpenApiGenSamplePackage"]
        ),
    ]
)
