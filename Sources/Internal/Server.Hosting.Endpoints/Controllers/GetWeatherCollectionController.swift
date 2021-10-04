import Server;

import WeatherCommon;
import WeatherServer;

internal class GetWeatherCollectionController: Controller {
    private let _action: GetWeathers;

    internal init(with action: GetWeathers) {
        _action = action;
    }

    public override func GetMethod() -> HttpMethod {
        return .get;
    }

    public override func GetRoute() -> String {
        return "/weather";
    }

    public override func Logic(withRequest request: RequestContext) async throws -> ResultContext {
        let weathers: [Weather] = try await _action.Get();

        return Ok(body: weathers);
    }
}