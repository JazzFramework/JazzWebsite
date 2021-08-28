import Configuration;
import Server;

import WeatherServer;

public class GetWeatherActionInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { sp in
                return GetWeatherAction(
                    with: try sp.FetchType()
                ) as GetWeather;
            });
    }
}