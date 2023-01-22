import WindmillConfiguration;
import WindmillCore;

public final class HelloWorldBackgroundProcessInitializer: Initializer {
    public required init() {}

    public final override func initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = configurationBuilder
            .with(decoder: BackgroundJobConfigV1JsonCodec())
            .with(
                file: "helloWorldBackgroundProcessSettings.json",
                for: BackgroundJobConfigV1JsonCodec.supportedMediaType
            );

        _ = try app
            .wireUp(backgroundProcess: { sp in
                return HelloWorldBackgroundProcess(
                    config: try await sp.fetchType(),
                    eventSubscriber: try await sp.fetchType(),
                    fetchAction: try await sp.fetchType(),
                    deleteAction: try await sp.fetchType()
                );
            });
    }
}