// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CaptureSdkCapacitor",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CaptureSdkCapacitor",
            targets: ["CaptureSDKPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "CaptureSDKPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/CaptureSDKPlugin"),
        .testTarget(
            name: "CaptureSDKPluginTests",
            dependencies: ["CaptureSDKPlugin"],
            path: "ios/Tests/CaptureSDKPluginTests")
    ]
)