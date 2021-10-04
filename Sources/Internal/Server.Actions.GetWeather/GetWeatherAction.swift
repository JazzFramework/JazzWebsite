import DataAccess;

import WeatherCommon;
import WeatherServer;

internal class GetWeatherAction: GetWeather {
    private let _repo: WeatherRepository;

    internal init(with repo: WeatherRepository) {
        _repo = repo;
    }

    public func Get(weatherId: String) async throws -> Weather {
        return try await _repo.Get(id: weatherId);
    }
}