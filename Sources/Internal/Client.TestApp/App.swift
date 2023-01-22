import Foundation;

import WindmillConfiguration;
import WindmillConsole;
import WindmillCore;

import WeatherServer;

@main
struct App {
    static func main() async throws {
        try await ConsoleAppRunner(
            withApp:
                try ConsoleAppBuilder()
                    .build()
                    .wireUp(logic: { sp in
                        return Entrypoint(createWeather: try await sp.fetchType());
                    }),
            withInitializers:
                InitializerBuilder()
                    .with(bundle: Bundle.module)
                    .build(),
            withConfiguration: 
                ConfigurationBuilder()
                    .with(bundle: Bundle.module)
        )
            .run();
    }
}