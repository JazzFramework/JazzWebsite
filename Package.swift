// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherService",
    platforms: [
        .macOS(.v13),
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
        .package(name: "Windmill", url: "../swift-framework", .upToNextMinor(from: "0.0.7")),
        .package(name: "SwiftServerExtensions", url: "../SwiftServerExtensions", .upToNextMinor(from: "0.0.7")),
    ],
    targets: [
        .target(
            name: "WeatherCommon",
            dependencies: [
                .product(name: "WindmillCodec", package: "Windmill"),
                .product(name: "WindmillServer", package: "Windmill"),
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
                .product(name: "WindmillClient", package: "Windmill"),
                .product(name: "WindmillDataAccess", package: "Windmill"),
                .product(name: "WindmillServer", package: "Windmill"),

                "WeatherClient"
            ],
            path: "Sources/Internal/Client.Http"
        ),
        .executableTarget(
            name: "WeatherClientTestApp",
            dependencies: [
                .product(name: "WindmillConsole", package: "Windmill"),
                .product(name: "WindmillEventing", package: "Windmill"),
                .product(name: "WindmillLab", package: "Windmill"),
                .product(name: "WindmillLogging", package: "Windmill"),
                .product(name: "WindmillMessaging", package: "Windmill"),
                .product(name: "WindmillMetrics", package: "Windmill"),

                "WeatherServer",
                "WeatherServerDataAccessInMemory",
                "WeatherServerActionsCreateWeather",
                "WeatherServerActionsDeleteWeather",
                "WeatherServerActionsGetWeather",
                "WeatherServerActionsGetWeathers",
                "WeatherServerActionsUpdateWeather",
                "WeatherServerHelloWorldBackgroundProcess",
            ],
            path: "Sources/Internal/Client.TestApp",
            resources: [
                .process("Settings")
            ]
        ),
        .target(
            name: "WeatherServerActionsCreateWeather",
            dependencies: [
                .product(name: "WindmillFlow", package: "Windmill"),
                .product(name: "WindmillServer", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.Actions.CreateWeather"
        ),
        .target(
            name: "WeatherServerActionsDeleteWeather",
            dependencies: [
                .product(name: "WindmillEventing", package: "Windmill"),
                .product(name: "WindmillServer", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.Actions.DeleteWeather"
        ),
        .target(
            name: "WeatherServerActionsGetWeather",
            dependencies: [
                .product(name: "WindmillServer", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.Actions.GetWeather"
        ),
        .target(
            name: "WeatherServerActionsGetWeathers",
            dependencies: [
                .product(name: "WindmillServer", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.Actions.GetWeathers"
        ),
        .target(
            name: "WeatherServerActionsUpdateWeather",
            dependencies: [
                .product(name: "WindmillServer", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.Actions.UpdateWeather"
        ),
        .target(
            name: "WeatherServerHelloWorldBackgroundProcess",
            dependencies: [
                .product(name: "WindmillEventing", package: "Windmill"),
                .product(name: "WindmillServer", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.HelloWorldBackgroundProcess"
        ),
        .target(
            name: "WeatherServerDataAccessInMemory",
            dependencies: [
                .product(name: "WindmillDataAccess", package: "Windmill"),
                .product(name: "WindmillDataAccessInMemory", package: "Windmill"),
                .product(name: "WindmillServer", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.DataAccess.InMemory"
        ),
        .target(
            name: "WeatherServerErrorsWeatherInvalidTempErrorTranslator",
            dependencies: [
                .product(name: "WindmillServer", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.Errors.WeatherInvalidTempErrorTranslator"
        ),
        .target(
            name: "WeatherServerHostingEndpoints",
            dependencies: [
                .product(name: "WindmillLogging", package: "Windmill"),
                .product(name: "WindmillServer", package: "Windmill"),

                "WeatherServer"
            ],
            path: "Sources/Internal/Server.Hosting.Endpoints"
        ),
        .executableTarget(
            name: "WeatherServerHostingApp",
            dependencies: [
                .product(name: "WindmillEventing", package: "Windmill"),
                .product(name: "WindmillLab", package: "Windmill"),
                .product(name: "WindmillLogging", package: "Windmill"),
                .product(name: "WindmillMessaging", package: "Windmill"),
                .product(name: "WindmillMetrics", package: "Windmill"),
                .product(name: "WindmillServerHummingbird", package: "Windmill"),

                .product(name: "WindmillServerRequestLogging", package: "SwiftServerExtensions"),
                .product(name: "WindmillServerAuthentication", package: "SwiftServerExtensions"),

                "WeatherServer",
                "WeatherServerDataAccessInMemory",
                "WeatherServerActionsCreateWeather",
                "WeatherServerActionsDeleteWeather",
                "WeatherServerActionsGetWeather",
                "WeatherServerActionsGetWeathers",
                "WeatherServerActionsUpdateWeather",
                "WeatherServerErrorsWeatherInvalidTempErrorTranslator",
                "WeatherServerHelloWorldBackgroundProcess",
                "WeatherServerHostingEndpoints"
            ],
            path: "Sources/Internal/Server.Hosting.App",
            resources: [
                .process("Assets"),
                .process("Settings")
            ]
        ),
    ]
)