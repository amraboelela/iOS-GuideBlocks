// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iOS-GuideBlocks",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "iOS-GuideBlocks",
            targets: ["iOS-GuideBlocks"]),
    ],
    dependencies: [
        .package(
          name:"Contextual", 
          url: "https://github.com/contextu-al/Contextual-SDK", 
          .upToNextMajor(from: "3.0.1"))
    ],
    targets: [
        .target(
            name: "iOS-GuideBlocks",
            dependencies: [
              .product(name: "ContextualSDK", package: "Contextual")
            ]
        ),
    ]
)
