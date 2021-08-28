import Configuration;
import Server;

import WeatherServer;

public final class GetWeathersActionInitializer: Initializer {
    public required init() {}

    public final override func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { sp in
                return GetWeathersAction(
                    with: try sp.FetchType()
                ) as GetWeathers;
            });
    }
}