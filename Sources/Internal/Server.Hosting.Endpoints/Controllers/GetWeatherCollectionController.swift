import WindmillServer;

import WeatherCommon;
import WeatherServer;

internal final class GetWeatherCollectionController: ApiController {
    private let _action: GetWeathers;

    internal init(action: GetWeathers) {
        _action = action;
    }

    public override func getMethod() -> HttpMethod { return .get; }
    public override func getRoute() -> String { return "/v1/weather"; }
    public override func logic(withRequest request: RequestContext) async throws -> ResultContext {
        let weathers: [Weather] = try await _action.get();

        return ok(body: weathers);
    }
}