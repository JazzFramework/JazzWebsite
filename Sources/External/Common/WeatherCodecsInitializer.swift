import Configuration;
import Server;

public final class WeatherCodecsInitializer: Initializer {
    public required init() {}

    public final override func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(transcoder: { _ in
                return WeatherV1JsonCodec();
            })

            .WireUp(transcoder: { _ in
                return WeatherCollectionV1JsonCodec();
            });
    }
}