// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JassWebsite",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .executable(
            name: "ServerApp",
            targets: ["ServerApp"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/JazzFramework/Jazz.git", from: "0.0.8"),
        .package(url: "https://github.com/JazzFramework/JazzServerNio.git", from: "0.0.8"),
        .package(url: "https://github.com/JazzFramework/JazzTemplatingEngineStencil.git", from: "0.0.8"),
    ],
    targets: [
        .executableTarget(
            name: "ServerApp",
            dependencies: [
                .product(name: "JazzServerHummingbird", package: "JazzServerNio"),
                .product(name: "JazzTemplatingEngineStencil", package: "JazzTemplatingEngineStencil")
            ],
            path: "Sources",
            resources: [
                .copy("Resources/Settings"),
                .copy("Resources/Public"),
                .copy("Resources/Views")
            ]
        ),
    ]
)