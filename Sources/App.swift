import Foundation;

import JazzConfiguration;
import JazzCore;
import JazzServer;

/**
 * Server entry point
 */
@main
struct App {
    /**
     * Entrypoint function
     */
    static func main() async throws {
        try await ServerAppRunner(
            withApp:
                try ServerAppBuilder()
                    .build(),
            withInitializers:
                try InitializerBuilder()
                    .with(bundle: Bundle.module)
                    .with(filename: "Settings/initializers")
                    .build(),
            withConfiguration:
                ConfigurationBuilder()
                    .with(bundle: Bundle.module)
        )
            .run();
    }
}