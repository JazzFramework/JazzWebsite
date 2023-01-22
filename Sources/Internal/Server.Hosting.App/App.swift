import Foundation;

import WindmillConfiguration;
import WindmillCore;
import WindmillServer;
import WindmillServerHummingbird;

@main
struct App {
    static func main() async throws {
        try await ServerAppRunner(
            withApp:
                try ServerAppBuilder()
                    .with(httpProcessor: HummingbirdHttpProcessor())
                    .build(),
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