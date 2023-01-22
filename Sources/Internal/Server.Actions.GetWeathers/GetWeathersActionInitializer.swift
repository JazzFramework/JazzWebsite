import WindmillConfiguration;
import WindmillCore;

import WeatherServer;

public final class GetWeathersActionInitializer: Initializer {
    public required init() {}

    public final override func initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(singleton: { sp in return GetWeathersAction(repo: try await sp.fetchType()) as GetWeathers; });
    }
}