import WeatherCommon;
import WeatherServer;

internal class UpdateWeatherAction: UpdateWeather {
    private let _repo: WeatherRepository;

    internal init(with repo: WeatherRepository) {
        _repo = repo;
    }

    public func Update(weather: Weather) async throws -> Weather {
        return try await _repo.Update(weather);
    }
}