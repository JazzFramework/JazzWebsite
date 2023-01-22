import WindmillConfiguration;
import WindmillServer;

public final class EndpointsInitializer: ServerInitializer {
    public required init() {}

    public override func initialize(for app: ServerApp, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(controller: { sp in
                return CreateWeatherController(
                    logger: try await sp.fetchType(),
                    metrics: try await sp.fetchType(),
                    action: try await sp.fetchType()
                );
            })
            //.wireUp(controller: { sp in return FileServerController(path: "/assets/:path", local: "assets", ); })
            .wireUp(controller: { sp in return DeleteWeatherController(action: try await sp.fetchType()); })
            .wireUp(controller: { sp in return GetWeatherCollectionController(action: try await sp.fetchType()); })
            .wireUp(controller: { sp in return GetWeatherController(action: try await sp.fetchType()); })
            .wireUp(controller: { sp in return UpdateWeatherController(action: try await sp.fetchType()); });
    }
}