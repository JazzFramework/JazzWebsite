import Configuration;
import Server;

public final class WeatherInvalidTempErrorTranslatorInitializer: ServerInitializer {
    public required init() {}

    public final override func Initialize(for app: ServerApp, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(errorTranslator: { _ in
                return WeatherInvalidTempErrorTranslator();
            });
    }
}