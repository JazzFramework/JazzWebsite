import Foundation;

import Configuration;
import Server;
import ServerNio;

@main
struct App {
    static func main() async throws {
        try await ServerAppRunner(
            withApp:
                try ServerAppBuilder()
                    .With(httpProcessor: HummingbirdHttpProcessor())
                    .Build(),
            withInitializers:
                InitializerBuilder()
                    .With(bundle: Bundle.module)
                    .Build(),
            withConfiguration: 
                ConfigurationBuilder()
                    .With(bundle: Bundle.module)
        )
            .Run();
    }
}