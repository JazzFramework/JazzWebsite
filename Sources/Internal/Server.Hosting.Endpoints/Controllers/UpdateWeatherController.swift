import WindmillServer;

import WeatherServer;
import WeatherCommon;

internal final class UpdateWeatherController: ApiController {
    private let _action: UpdateWeather;

    internal init(action: UpdateWeather) {
        _action = action;
    }

    public override func getMethod() -> HttpMethod { return .put; }
    public override func getRoute() -> String { return "/v1/weather"; }
    public override func logic(withRequest request: RequestContext) async throws -> ResultContext {
        guard let input: Weather = try request.getBody() else {
            throw ControllerErrors.missingBody;
        }

        let weather: Weather = try await _action.update(weather: input);

        return ok(body: weather);
    }
}