import WindmillServer;

import WeatherServer;

internal final class DeleteWeatherController: ApiController {
    private let _action: DeleteWeather;

    internal init(action: DeleteWeather) {
        _action = action;
    }

    public override func getMethod() -> HttpMethod { return .delete; }
    public override func getRoute() -> String { return "/v1/weather/:id"; }
    public override func logic(withRequest request: RequestContext) async throws -> ResultContext {
        let weatherId: String = request.getRouteParameter(key: "id");

        try await _action.delete(weatherId: weatherId);

        return noContent();
    }
}