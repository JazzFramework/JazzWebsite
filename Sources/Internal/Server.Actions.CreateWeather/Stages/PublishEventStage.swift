import WindmillContext;
import WindmillEventing;
import WindmillFlow;

import WeatherCommon;
import WeatherServer;

internal final class PublishEventStage: BaseStage {
    internal static let NAME: String = "\(PublishEventStage.self)"

    internal static let SUCCESS_RESULT: StageResult =
        StageResult(as: "\(PublishEventStage.NAME) success");

    internal static let MISSING_CONTEXT_RESULT: StageResult =
        StageResult(as: "\(PublishEventStage.NAME) missing context");

    private let _contextResolver: ContextResolver<FlowContext, WeatherContext>;
    private let _eventPublisher: EventPublisher;

    internal init(
        withContextResolver contextResolver: ContextResolver<FlowContext, WeatherContext>,
        withEventPublisher eventPublisher: EventPublisher,
        withTransactions transactions: [StageResult:String]
    ) {
        _contextResolver = contextResolver;
        _eventPublisher = eventPublisher;

        super.init(withTransactions: transactions);
    }

    public override func execute(for context: FlowContext) async throws -> StageResult {
        guard let weatherContext: WeatherContext = _contextResolver.resolve(for: context) else {
            return PublishEventStage.MISSING_CONTEXT_RESULT;
        }

        let event: Event<Weather> = Event<Weather>(type: "WEATHER_CREATED", value: weatherContext.value);

        await _eventPublisher.publish(event: event, on: "WEATHER_CREATED");

        return PublishEventStage.SUCCESS_RESULT;
    }
}