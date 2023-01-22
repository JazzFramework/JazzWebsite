import WindmillServer;

import WeatherServer;
import WeatherCommon;

internal final class GetWeatherController: ApiController {
    private let _action: GetWeather;

    internal init(action: GetWeather) {
        _action = action;
    }

    public override func getMethod() -> HttpMethod { return .get; }
    public override func getRoute() -> String { return "/v1/weather/:id"; }
    public override func logic(withRequest request: RequestContext) async throws -> ResultContext {
        let weatherId: String = request.getRouteParameter(key: "id");

        let weather: Weather = try await _action.get(weatherId: weatherId);

        return ok(body: weather);
    }
}