import WindmillDataAccess;

import WeatherCommon;
import WeatherServer;

internal class DeleteWeatherAction: DeleteWeather {
    private let _repo: Repository<Weather>;

    internal init(repo: Repository<Weather>) {
        _repo = repo;
    }

    public func delete(weatherId: String) async throws {
        try await _repo.delete(id: weatherId, with: []);
    }
}