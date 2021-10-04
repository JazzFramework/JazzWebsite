import Configuration;
import Server;

public final class EndpointsInitializer: ServerInitializer {
    public required init() {}

    public override func Initialize(for app: ServerApp, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(controller: { sp in
                return CreateWeatherController(with: try await sp.FetchType());
            })

            .WireUp(controller: { sp in
                return DeleteWeatherController(with: try await sp.FetchType());
            })

            .WireUp(controller: { sp in
                return GetWeatherCollectionController(with: try await sp.FetchType());
            })

            .WireUp(controller: { sp in
                return GetWeatherController(with: try await sp.FetchType());
            })

            .WireUp(controller: { sp in
                return UpdateWeatherController(with: try await sp.FetchType());
            });
    }
}