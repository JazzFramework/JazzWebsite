import WindmillContext;
import WindmillDataAccess;
import WindmillEventing;
import WindmillFlow;

import WeatherCommon;
import WeatherServer;

internal final class CreateWeatherActionBuilder {
    private static let WEATHER_CONTEXT_RESOLVER: ContextResolver<FlowContext, WeatherContext> =
        ContextResolver<FlowContext, WeatherContext>();

    private var _repository: Repository<Weather>?;
    private var _eventPublisher: EventPublisher?;

    internal func with(repo: Repository<Weather>) -> CreateWeatherActionBuilder
    {
        _repository = repo;

        return self;
    }

    internal func with(eventPublisher: EventPublisher) -> CreateWeatherActionBuilder
    {
        _eventPublisher = eventPublisher;

        return self;
    }

    internal func build() throws -> CreateWeather {
        if let repository = _repository, let eventPublisher = _eventPublisher {
            return CreateWeatherAction(
                withFlow: CreateWeatherActionBuilder.buildFlow(repository, eventPublisher),
                withResultResolver: CreateWeatherActionBuilder.WEATHER_CONTEXT_RESOLVER
            );
        }

        throw ContextErrors.notResolveable(reason: "could not wire flow.");
    }

    private static func buildFlow(_ repository: Repository<Weather>, _ eventPublisher: EventPublisher) -> Flow {
        return FlowBuilder()
            .with(stage: CreateWeatherActionBuilder.buildValidateWeatherStage(), withName: ValidateWeatherStage.NAME)
            .with(stage: CreateWeatherActionBuilder.buildSetWeatherIdStage(), withName: SetWeatherIdStage.NAME)
            .with(stage: CreateWeatherActionBuilder.buildPersistWeatherStage(repository), withName: PersistWeatherStage.NAME)
            .with(stage: CreateWeatherActionBuilder.buildPublishEventStage(eventPublisher), withName: PublishEventStage.NAME)
            .with(initialStage: ValidateWeatherStage.NAME)
            .build();
    }

    private static func buildValidateWeatherStage() -> ValidateWeatherStage {
        return ValidateWeatherStage(
            withContextResolver: CreateWeatherActionBuilder.WEATHER_CONTEXT_RESOLVER,
            withTransactions: [
                ValidateWeatherStage.SUCCESS_RESULT: SetWeatherIdStage.NAME
            ]
        );
    }

    private static func buildSetWeatherIdStage() -> SetWeatherIdStage {
        return SetWeatherIdStage(
            withContextResolver: CreateWeatherActionBuilder.WEATHER_CONTEXT_RESOLVER,
            withTransactions: [
                SetWeatherIdStage.SUCCESS_RESULT: PersistWeatherStage.NAME
            ]
        );
    }

    private static func buildPersistWeatherStage(_ repository: Repository<Weather>) -> PersistWeatherStage {
        return PersistWeatherStage(
            withContextResolver: CreateWeatherActionBuilder.WEATHER_CONTEXT_RESOLVER,
            withRepository: repository,
            withTransactions: [
                PersistWeatherStage.SUCCESS_RESULT: PublishEventStage.NAME
            ]
        );
    }

    private static func buildPublishEventStage(_ eventPublisher: EventPublisher) -> PublishEventStage {
        return PublishEventStage(
            withContextResolver: CreateWeatherActionBuilder.WEATHER_CONTEXT_RESOLVER,
            withEventPublisher: eventPublisher,
            withTransactions: [:]
        );
    }
}
