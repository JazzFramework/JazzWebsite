import Configuration;
import Server;

import WeatherServer;

public class GetWeathersActionInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { sp in
                return GetWeathersAction(
                    with: try sp.FetchType()
                ) as GetWeathers;
            });
    }
}