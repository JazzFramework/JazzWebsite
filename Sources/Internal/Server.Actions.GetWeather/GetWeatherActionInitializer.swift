import Configuration;
import Server;

import WeatherServer;

public final class GetWeatherActionInitializer: Initializer {
    public required init() {}

    public final override func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { sp in
                return GetWeatherAction(
                    with: try sp.FetchType()
                ) as GetWeather;
            });
    }
}