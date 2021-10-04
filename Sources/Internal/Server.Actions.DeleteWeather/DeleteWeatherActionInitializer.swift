import Configuration;
import Server;

import WeatherServer;

public final class DeleteWeatherActionInitializer: Initializer {
    public required init() {}

    public final override func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { sp in
                return DeleteWeatherAction(
                    with: try await sp.FetchType()
                ) as DeleteWeather;
            });
    }
}