import WindmillConfiguration;
import WindmillCore;
import WindmillDataAccess;
import WindmillEventing;

import WeatherCommon;
import WeatherServer;

public final class CreateWeatherActionInitializer: Initializer {
    public required init() {}

    public final override func initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(singleton: { sp in return try self.buildAction(repo: try await sp.fetchType(), eventPublisher: try await sp.fetchType()); });
    }

    private func buildAction(repo: Repository<Weather>, eventPublisher: EventPublisher) throws -> CreateWeather {
        return try CreateWeatherActionBuilder().with(repo: repo).with(eventPublisher: eventPublisher).build();
    }
}