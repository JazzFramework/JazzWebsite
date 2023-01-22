import Foundation;

import WindmillContext;
import WindmillFlow;

internal final class SetWeatherIdStage: BaseStage {
    internal static let NAME: String = "\(SetWeatherIdStage.self)"

    internal static let SUCCESS_RESULT: StageResult =
        StageResult(as: "\(SetWeatherIdStage.NAME) success");

    internal static let MISSING_CONTEXT_RESULT: StageResult =
        StageResult(as: "\(SetWeatherIdStage.NAME) missing context");

    private let _contextResolver: ContextResolver<FlowContext, WeatherContext>;

    internal init(
        withContextResolver contextResolver: ContextResolver<FlowContext, WeatherContext>,
        withTransactions transactions: [StageResult:String]
    ) {
        _contextResolver = contextResolver;

        super.init(withTransactions: transactions);
    }

    public override func execute(for context: FlowContext) async throws -> StageResult {
        guard let weatherContext: WeatherContext = _contextResolver.resolve(for: context) else {
            return SetWeatherIdStage.MISSING_CONTEXT_RESULT;
        }

        weatherContext.value.set(id: UUID().uuidString);

        return SetWeatherIdStage.SUCCESS_RESULT;
    }
}