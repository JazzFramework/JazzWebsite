import WindmillConfiguration;
import WindmillServer;

public final class WeatherInvalidTempErrorTranslatorInitializer: ServerInitializer {
    public required init() {}

    public final override func initialize(for app: ServerApp, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(errorTranslator: { _ in
                return WeatherInvalidTempErrorTranslator();
            });
    }
}