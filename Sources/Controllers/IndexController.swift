import JazzServer;

internal final class IndexController: HtmlController {
    internal override init(templatingEngine: TemplatingEngine) {
        super.init(templatingEngine: templatingEngine);
    }

    public final override func getRoute() -> String { return "/"; }
    public final override func logic(withRequest request: RequestContext) async throws -> HtmlControllerResult {
        return try await template("Views/Pages/index.html", [:]);
    }
}