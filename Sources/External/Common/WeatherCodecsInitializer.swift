import WindmillCodec;
import WindmillConfiguration;
import WindmillServer;

public final class WeatherCodecsInitializer: ServerInitializer {
    public required init() {}

    public final override func initialize(for app: ServerApp, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(transcoder: { _ in
                return WeatherV1JsonCodec();
            })

            .wireUp(transcoder: { _ in
                return WeatherV1JsonCodec.collectionCodec;
            });
    }
}