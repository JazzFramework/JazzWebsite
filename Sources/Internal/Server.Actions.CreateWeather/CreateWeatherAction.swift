import WindmillContext
import WindmillFlow

import WeatherCommon;
import WeatherServer;

internal final class CreateWeatherAction: CreateWeather {
    private let _flow: Flow;
    private let _resultResolver: ContextResolver<FlowContext, WeatherContext>;

    internal init(
        withFlow flow: Flow,
        withResultResolver resultResolver: ContextResolver<FlowContext, WeatherContext>
    ) {
        _flow = flow;
        _resultResolver = resultResolver;
    }

    public func create(weather: Weather) async throws -> Weather {
        let context = FlowContext();

        context.adopt(subcontext: WeatherContext(weather));

        _ = try await _flow.execute(for: context);

        if let weatherContext: WeatherContext = _resultResolver.resolve(for: context) {
            return weatherContext.value;
        }

        throw ContextErrors.notResolveable(reason: "Could not resolve weather context.");
    }
}