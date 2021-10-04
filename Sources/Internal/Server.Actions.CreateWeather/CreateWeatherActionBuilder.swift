import Context;
import Flow;

import WeatherServer;

internal final class CreateWeatherActionBuilder {
    private static let WEATHER_CONTEXT_RESOLVER: ContextResolver<FlowContext, WeatherContext> =
        ContextResolver<FlowContext, WeatherContext>();

    private var _repository: WeatherRepository?;

    internal func With(repository: WeatherRepository) -> CreateWeatherActionBuilder
    {
        _repository = repository;

        return self;
    }

    internal func Build() throws -> CreateWeather {
        if let repository = _repository {
            return CreateWeatherAction(
                withFlow: CreateWeatherActionBuilder.BuildFlow(repository),
                withResultResolver: CreateWeatherActionBuilder.WEATHER_CONTEXT_RESOLVER
            );
        }

        throw ContextErrors.notResolveable(reason: "could not wire flow.");
    }

    private static func BuildFlow(_ repository: WeatherRepository) -> Flow {
        return FlowBuilder()
            .With(stage: CreateWeatherActionBuilder.BuildValidateWeatherStage(), withName: ValidateWeatherStage.NAME)
            .With(stage: CreateWeatherActionBuilder.BuildSetWeatherIdStage(), withName: SetWeatherIdStage.NAME)
            .With(stage: CreateWeatherActionBuilder.BuildPersistWeatherStage(repository), withName: PersistWeatherStage.NAME)
            .With(initialStage: ValidateWeatherStage.NAME)
            .Build();
    }

    private static func BuildValidateWeatherStage() -> ValidateWeatherStage {
        return ValidateWeatherStage(
            withContextResolver: CreateWeatherActionBuilder.WEATHER_CONTEXT_RESOLVER,
            withTransactions: [
                ValidateWeatherStage.SUCCESS_RESULT: SetWeatherIdStage.NAME
            ]
        );
    }

    private static func BuildSetWeatherIdStage() -> SetWeatherIdStage {
        return SetWeatherIdStage(
            withContextResolver: CreateWeatherActionBuilder.WEATHER_CONTEXT_RESOLVER,
            withTransactions: [
                SetWeatherIdStage.SUCCESS_RESULT: PersistWeatherStage.NAME
            ]
        );
    }

    private static func BuildPersistWeatherStage(_ repository: WeatherRepository) -> PersistWeatherStage {
        return PersistWeatherStage(
            withContextResolver: CreateWeatherActionBuilder.WEATHER_CONTEXT_RESOLVER,
            withRepository: repository,
            withTransactions: [:]
        );
    }
}
