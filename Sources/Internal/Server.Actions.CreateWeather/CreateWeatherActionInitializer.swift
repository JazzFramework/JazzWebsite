import Configuration;
import Server;

import WeatherServer;

public final class CreateWeatherActionInitializer: Initializer {
    public required init() {}

    public final override func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { sp in
                return try CreateWeatherActionBuilder()
                    .With(repository: try await sp.FetchType())
                    .Build() as CreateWeather;
            });
    }
}