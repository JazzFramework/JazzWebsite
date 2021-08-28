import Configuration;
import Server;

import WeatherServer;

public final class InMemoryWeatherRepositoryInitializer: Initializer {
    public required init() {}

    public final override func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { _ in
                return InMemoryWeatherRepository() as WeatherRepository;
            });
    }
}