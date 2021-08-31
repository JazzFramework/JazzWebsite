import WeatherCommon;
import WeatherServer;

internal class UpdateWeatherAction: UpdateWeather {
    private let _repo: WeatherRepository;

    internal init(with repo: WeatherRepository) {
        _repo = repo;
    }

    public func Update(weather: Weather) throws -> Weather {
        return try _repo.Update(weather);
    }
}