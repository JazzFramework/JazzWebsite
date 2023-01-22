import WindmillDataAccess;

import WeatherCommon;
import WeatherServer;

internal class GetWeatherAction: GetWeather {
    private let _repo: Repository<Weather>;

    internal init(repo: Repository<Weather>) {
        _repo = repo;
    }

    public func get(weatherId: String) async throws -> Weather {
        return try await _repo.get(id: weatherId, with: []);
    }
}