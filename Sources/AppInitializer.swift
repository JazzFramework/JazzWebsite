import Foundation;

import JazzConfiguration;
import JazzServer;

public final class AppInitializer: ServerInitializer {
    public required init() {}

    public override func initialize(for app: ServerApp, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(singleton: { _ in return Bundle.module; })

            .wireUp(assetControllers: [
                "/favicon.ico": "/Public/favicon.ico",
                "/robots.txt": "/Public/robots.txt",
                "/assets/:path*": "/Public/"
            ])

            .wireUp(controller: { sp in return AboutController(templatingEngine: try await sp.fetchType()); })
            .wireUp(controller: { sp in return DocumentationController(templatingEngine: try await sp.fetchType()); })
            .wireUp(controller: { sp in return GettingStartedController(templatingEngine: try await sp.fetchType()); })
            .wireUp(controller: { sp in return IndexController(templatingEngine: try await sp.fetchType()); })
            .wireUp(controller: { sp in return ReleasesController(templatingEngine: try await sp.fetchType()); })
            .wireUp(controller: { sp in return SupportController(templatingEngine: try await sp.fetchType()); });
    }
}