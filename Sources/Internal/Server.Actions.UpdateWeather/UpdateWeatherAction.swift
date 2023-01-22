import WindmillDataAccess;

import WeatherCommon;
import WeatherServer;

internal class UpdateWeatherAction: UpdateWeather {
    private let _repo: Repository<Weather>;

    internal init(repo: Repository<Weather>) {
        _repo = repo;
    }

    public func update(weather: Weather) async throws -> Weather {
        return try await _repo.update(weather, with: []);
    }
}