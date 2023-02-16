import JazzServer;

internal final class ReleasesController: HtmlController {
    internal override init(templatingEngine: TemplatingEngine) {
        super.init(templatingEngine: templatingEngine);
    }

    public final override func getRoute() -> String { return "/releases"; }
    public final override func logic(withRequest request: RequestContext) async throws -> HtmlControllerResult {
        return try await template("Views/Pages/releases.html", ["notes": ["1 abc", "2 def"]]);
    }
}