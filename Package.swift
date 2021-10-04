// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherService",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        .executable(
            name: "WeatherServer",
            targets: ["WeatherServerHostingApp"]
        ),
        .library(
            name: "WeatherClient",
            targets: ["WeatherHttpClient"]
        ),
        .executable(
            name: "WeatherClientTest",
            targets: ["WeatherClientTestApp"]
        ),
    ],
    dependencies: [
        .package(name: "Windmill", url: "https://github.com/nathanmentley/swift-framework", .upToNextMinor(from: "0.0.6")),
        .package(name: "SwiftServerExtensions", url: "https://github.com/nathanmentley/SwiftServerExtensions", .upToNextMinor(from: "0.0.6")),
    ],
    targets: [
        .target(
            name: "WeatherCommon",
            dependencies: [
                .product(name: "Codec", package: "Windmill"),
                .product(name: "Server", package: "Windmill"),
            ],
            path: "Sources/External/Common"
        ),
        .target(
            name: "WeatherClient",
            dependencies: [
                "WeatherCommon"
            ],
            path: "Sources/External/Client"
        ),
        .target(
            name: "WeatherServer",
            dependencies: [
                "WeatherCommon"
            ],
            path: "Sources/External/Server"
        ),
        .target(
            name: "WeatherHttpClient",
            dependencies: [
                .product(name: "Client", package: "Windmill"),
                .product(name: "DataAccess", package: "Windmill"),
                .product(name: "ErrorHandling", package: "Windmill"),
                .product(name: "Server", package: "Windmill"),

                "WeatherClient"
            ],
            path: "Sources/Internal/Client.Http"
        ),
        .executableTarget(
            name: "WeatherClientTestApp",
            dependencies: [
                "WeatherHttpClient"
            ],
            path: "Sources/Internal/Client.TestApp"
        ),
        .target(
            name: "WeatherServerActionsCreateWeather",
            dependencies: [
                .product(name: "Flow", package: "Windmill"),
                .product(name: "Server", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.Actions.CreateWeather"
        ),
        .target(
            name: "WeatherServerActionsDeleteWeather",
            dependencies: [
                .product(name: "Server", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.Actions.DeleteWeather"
        ),
        .target(
            name: "WeatherServerActionsGetWeather",
            dependencies: [
                .product(name: "Server", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.Actions.GetWeather"
        ),
        .target(
            name: "WeatherServerActionsGetWeathers",
            dependencies: [
                .product(name: "Server", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.Actions.GetWeathers"
        ),
        .target(
            name: "WeatherServerActionsUpdateWeather",
            dependencies: [
                .product(name: "Server", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.Actions.UpdateWeather"
        ),
        .target(
            name: "WeatherServerHelloWorldBackgroundProcess",
            dependencies: [
                .product(name: "ErrorHandling", package: "Windmill"),
                .product(name: "Server", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.HelloWorldBackgroundProcess"
        ),
        .target(
            name: "WeatherServerDataAccessInMemory",
            dependencies: [
                .product(name: "DataAccess", package: "Windmill"),
                .product(name: "Server", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.DataAccess.InMemory"
        ),
        .target(
            name: "WeatherServerErrorsWeatherErrorsWeatherInvalidTempErrorTranslator",
            dependencies: [
                .product(name: "Server", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.Errors.WeatherErrors.WeatherInvalidTempErrorTranslator"
        ),
        .target(
            name: "WeatherServerHostingEndpoints",
            dependencies: [
                .product(name: "Server", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.Hosting.Endpoints"
        ),
        .executableTarget(
            name: "WeatherServerHostingApp",
            dependencies: [
                .product(name: "ServerNio", package: "Windmill"),

                .product(name: "ServerRequestLogging", package: "SwiftServerExtensions"),
                .product(name: "ServerAuthentication", package: "SwiftServerExtensions"),

                "WeatherServer",
                "WeatherServerDataAccessInMemory",
                "WeatherServerActionsCreateWeather",
                "WeatherServerActionsDeleteWeather",
                "WeatherServerActionsGetWeather",
                "WeatherServerActionsGetWeathers",
                "WeatherServerActionsUpdateWeather",
                "WeatherServerErrorsWeatherErrorsWeatherInvalidTempErrorTranslator",
                "WeatherServerHelloWorldBackgroundProcess",
                "WeatherServerHostingEndpoints"
            ],
            path: "Sources/Internal/Server.Hosting.App",
            resources: [
                .process("Settings")
            ]
        ),
    ]
)