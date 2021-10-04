import WeatherServer;

internal class DeleteWeatherAction: DeleteWeather {
    private let _repo: WeatherRepository;

    internal init(with repo: WeatherRepository) {
        _repo = repo;
    }

    public func Delete(weatherId: String) async throws {
        try await _repo.Delete(id: weatherId);
    }
}