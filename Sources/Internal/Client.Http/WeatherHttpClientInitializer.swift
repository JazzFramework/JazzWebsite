import WindmillClient;
import WindmillConfiguration;
import WindmillCore;

import WeatherClient;

public final class WeatherClientInitializer: Initializer {
    public required init() {}

    public final override func initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = configurationBuilder
            .with(decoder: WeatherHttpClientConfigV1JsonCodec())
            .with(
                file: "weatherClientHttpSettings.json",
                for: WeatherHttpClientConfigV1JsonCodec.supportedMediaType
            );

        _ = try app
            .wireUp(singleton: { sp in
                return WeatherHttpClient(
                    with: try await sp.fetchType()
                ) as WeatherClient;
            });
    }
}