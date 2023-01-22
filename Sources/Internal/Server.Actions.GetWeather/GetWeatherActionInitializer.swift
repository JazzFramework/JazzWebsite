import WindmillConfiguration;
import WindmillCore;

import WeatherServer;

public final class GetWeatherActionInitializer: Initializer {
    public required init() {}

    public final override func initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(singleton: { sp in return GetWeatherAction(repo: try await sp.fetchType()) as GetWeather; });
    }
}