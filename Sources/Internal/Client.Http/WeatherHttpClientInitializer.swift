import Client;
import Configuration;
import Server;

import WeatherCommon;
import WeatherClient;

public final class WeatherClientInitializer: Initializer {
    public required init() {}

    public final override func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = configurationBuilder
            .With(decoder: WeatherHttpClientConfigV1JsonCodec())
            .With(
                file: "weatherClientHttpSettings.json",
                for: WeatherHttpClientConfigV1JsonCodec.SupportedMediaType
            );

        _ = try app
            .WireUp(singleton: { sp in
                return WeatherHttpClient(
                    with: try sp.FetchType(),
                    with: [
                        WeatherHttpClientErrorMapper(),
                        ClientErrorMapper()
                    ]
                ) as WeatherClient;
            });
    }
}