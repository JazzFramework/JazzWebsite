import Configuration;
import Server;

import WeatherServer;

public class CreateWeatherActionInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { sp in
                return CreateWeatherActionBuilder(
                    with: try sp.FetchType()
                )
                    .Build() as CreateWeather;
            });
    }
}