import Configuration;
import Server;

public final class WeatherInvalidTempErrorTranslatorInitializer: Initializer {
    public required init() {}

    public final override func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(errorTranslator: { _ in
                return WeatherInvalidTempErrorTranslator();
            });
    }
}