import WindmillConfiguration;
import WindmillCore;
import WindmillDataAccess;

import WeatherCommon;
import WeatherServer;

public final class DeleteWeatherActionInitializer: Initializer {
    public required init() {}

    public final override func initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app.wireUp(singleton: { sp in return self.Build(try await sp.fetchType()); });
    }

    private func Build(_ repo: Repository<Weather>) -> DeleteWeather {
        return DeleteWeatherAction(repo: repo);
    }
}