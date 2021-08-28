import Configuration;
import Server;

import WeatherCommon;

public final class WeatherClientInitializer: Initializer {
    public required init() {}

    public final override func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { _ in
                return WeatherClientImpl() as WeatherClient;
            });
    }
}