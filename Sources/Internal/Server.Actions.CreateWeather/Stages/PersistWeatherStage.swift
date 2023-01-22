import WindmillContext;
import WindmillDataAccess;
import WindmillFlow;

import WeatherCommon;
import WeatherServer;

internal final class PersistWeatherStage: BaseStage {
    internal static let NAME: String = "\(PersistWeatherStage.self)"

    internal static let SUCCESS_RESULT: StageResult =
        StageResult(as: "\(PersistWeatherStage.NAME) success");

    internal static let MISSING_CONTEXT_RESULT: StageResult =
        StageResult(as: "\(PersistWeatherStage.NAME) missing context");

    private let _contextResolver: ContextResolver<FlowContext, WeatherContext>;
    private let _repository: Repository<Weather>;

    internal init(
        withContextResolver contextResolver: ContextResolver<FlowContext, WeatherContext>,
        withRepository repository: Repository<Weather>,
        withTransactions transactions: [StageResult:String]
    ) {
        _contextResolver = contextResolver;
        _repository = repository;

        super.init(withTransactions: transactions);
    }

    public override func execute(for context: FlowContext) async throws -> StageResult {
        guard let weatherContext: WeatherContext = _contextResolver.resolve(for: context) else {
            return PersistWeatherStage.MISSING_CONTEXT_RESULT;
        }

        let result: Weather = try await _repository.create(weatherContext.value, with: []);

        context.adopt(subcontext: WeatherContext(result));

        return PersistWeatherStage.SUCCESS_RESULT;
    }
}