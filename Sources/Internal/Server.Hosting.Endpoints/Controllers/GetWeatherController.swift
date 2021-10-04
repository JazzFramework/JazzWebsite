import Server;

import WeatherServer;
import WeatherCommon;

internal class GetWeatherController: Controller {
    private let _action: GetWeather;

    internal init(with action: GetWeather) {
        _action = action;
    }

    public override func GetMethod() -> HttpMethod {
        return .get;
    }

    public override func GetRoute() -> String {
        return "/weather/:id";
    }

    public override func Logic(withRequest request: RequestContext) async throws -> ResultContext {
        let weatherId: String = request.GetRouteParameter(key: "id");

        let weather: Weather = try await _action.Get(weatherId: weatherId);

        return Ok(body: weather);
    }
}