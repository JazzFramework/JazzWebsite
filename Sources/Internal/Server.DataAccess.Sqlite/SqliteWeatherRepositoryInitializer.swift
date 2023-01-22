import WindmillConfiguration;
import WindmillDataAccess;
import WindmillDataAccessSqlite;
import WindmillServer;

import WeatherCommon;

public final class SqliteWeatherRepositoryInitializer: Initializer {
    public required init() {}

    public final override func initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(singleton: { _ in
                return CriterionProcessorImpl<Weather>(
                    criterionHandlers: self.getCriterionHandlers()
                )
                    as CriterionProcessor<Weather>;
            })
            .wireUp(singleton: { _ in
                return HintProcessorImpl<Weather>(
                    hintHandlers: self.getHintHandlers()
                )
                    as HintProcessor<Weather>;
            })
            .wireUp(singleton: { sp in
                return SqliteRepository<Weather>(
                    criterionProcessor: try await sp.fetchType(),
                    hintProcessor: try await sp.fetchType()
                )
                    as Repository<Weather>;
            });
    }

    private func getHintHandlers() -> [HintHandler<Weather>] {
        return [
            MaxResultsHintHandler<Weather>()
        ];
    }

    private func getCriterionHandlers() -> [CriterionHandler<Weather>] {
        return [
            IdQueryCriterionHandler<Weather>(),
            IdsQueryCriterionHandler<Weather>(),
        ];
    }
}