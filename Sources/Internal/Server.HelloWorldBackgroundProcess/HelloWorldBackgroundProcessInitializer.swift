import Configuration;
import Server;

public final class HelloWorldBackgroundProcessInitializer: ServerInitializer {
    public required init() {}

    public final override func Initialize(for app: ServerApp, with configurationBuilder: ConfigurationBuilder) throws {
        _ = configurationBuilder
            .With(decoder: BackgroundJobConfigV1JsonCodec())
            .With(
                file: "helloWorldBackgroundProcessSettings.json",
                for: BackgroundJobConfigV1JsonCodec.SupportedMediaType
            );

        _ = try app
            .WireUp(backgroundProcess: { sp in
                return HelloWorldBackgroundProcess(
                    with: try await sp.FetchType(),
                    with: try await sp.FetchType(),
                    with: try await sp.FetchType()
                );
            });
    }
}