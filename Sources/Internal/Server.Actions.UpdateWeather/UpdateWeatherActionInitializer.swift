import Configuration;
import Server;

import WeatherServer;

public final class UpdateWeatherActionInitializer: Initializer {
    public required init() {}

    public final override func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { sp in
                return UpdateWeatherAction(
                    with: try sp.FetchType()
                ) as UpdateWeather;
            });
    }
}