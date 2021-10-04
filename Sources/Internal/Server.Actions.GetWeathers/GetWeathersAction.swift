import DataAccess;

import WeatherCommon;
import WeatherServer;

internal class GetWeathersAction: GetWeathers {
    private let _repo: WeatherRepository;

    internal init(with repo: WeatherRepository) {
        _repo = repo;
    }

    public func Get() async throws -> [Weather] {
        return try await _repo.Get(for: []);
    }
}