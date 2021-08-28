import DataAccess;

import WeatherCommon;
import WeatherServer;

internal class GetWeathersAction: GetWeathers {
    private let _repo: WeatherRepository;

    internal init(with repo: WeatherRepository) {
        _repo = repo;
    }

    public func Get() throws -> [Weather] {
        return try _repo.Get();
    }
}