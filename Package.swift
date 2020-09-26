// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "webrtc-core",
  products: [
    .library(name: "Core", targets: ["Core"])
  ],
  dependencies: [
    .package(url: "https://github.com/swift-webrtc/COpenSSL.git", .branch("master")),
    .package(url: "https://github.com/apple/swift-log.git", from: "1.4.0"),
  ],
  targets: [
    .target(
      name: "Core",
      dependencies: [
        "COpenSSL",
        .product(name: "Logging", package: "swift-log")
      ]
    ),
    .testTarget(name: "CoreTests", dependencies: ["Core"]),
  ]
)
