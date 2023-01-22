import WindmillLogging;
import WindmillMetrics;
import WindmillServer;

import WeatherCommon;
import WeatherServer;

/**
 An `ApiController` to expose an endpoint for clients to create `Weather` resources.

 This `ApiController` will respond with:
 - 200: If the `Weather` is created
 - 400: If the `Weather`'s temp is invalid
 - 500: If the `Weather` couldn't be created because the data couldn't be persisted
 */
internal final class CreateWeatherController: ApiController {
    private static let DIMENSIONS: [Dimension] = [
        DimensionBuilder()
            .with(value: "Service")
            .with(key: "WeatherService")
            .build(),
        DimensionBuilder()
            .with(value: "Controller")
            .with(key: "CreateWeatherController")
            .build(),
        DimensionBuilder()
            .with(value: "Metric")
            .with(key: "ExecutionTime")
            .build()
    ];

    private let logger: Logger;
    private let metrics: MetricManager;
    private let action: CreateWeather;

    /**
     Constructor
    
     - Parameters:
       - logger: The `Logger` implementation to use for the controller to log against.
       - metrics: The `MetricManager` implementation to use for the controller to publish against.
       - action: The `CreateWeather` action logic for the `ApiController` to invoke.
     */
    internal init(logger: Logger, metrics: MetricManager, action: CreateWeather) {
        self.logger = logger;
        self.metrics = metrics;
        self.action = action;
    }

    /**
     Fetches the `HttpMethod` for the `ApiController` to respond to.
    
     - Returns: The `HttpMethod` this `ApiController` should respond to.
     */
    public final override func getMethod() -> HttpMethod { return .post; }

    /**
     Fetches the URL Route for the `ApiController` to respond to.
    
     - Returns: The URL Route this `ApiController` should respond to.
     */
    public final override func getRoute() -> String { return "/v1/weather"; }

    /**
     Runs the `ApiController` logic that'll invoke the `CreateWeather` logic exposed by the injected action
    
     - Parameters:
       - request: The `RequestContext` containing the request data sent from the client.
    
     - Returns: A `ResultContext` containing the response data to be returned to the client.
    
     - Throws: `ControllerErrors.missingBody` if the passed body is missing or in the invalid format.
     */
    public final override func logic(withRequest request: RequestContext) async throws -> ResultContext {
        let weather: Weather = try await metrics.recordTime(for: CreateWeatherController.DIMENSIONS) {
            guard let input: Weather = try request.getBody() else {
                await logger.debug("Bailing from CreateWeatherController, because there wasn't a valid body passed in.");

                throw ControllerErrors.missingBody;
            }

            await logger.verbose("Calling CreateWeatherAction from CreateWeatherController");

            return try await action.create(weather: input);
        };

        return ok(body: weather);
    }
}