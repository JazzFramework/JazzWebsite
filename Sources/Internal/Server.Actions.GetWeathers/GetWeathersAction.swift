import WindmillDataAccess;

import WeatherCommon;
import WeatherServer;

internal class GetWeathersAction: GetWeathers {
    private let _repo: Repository<Weather>;

    internal init(repo: Repository<Weather>) {
        _repo = repo;
    }

    public func get() async throws -> [Weather] {
        return try await _repo.get(for: [], with: []);
    }
}