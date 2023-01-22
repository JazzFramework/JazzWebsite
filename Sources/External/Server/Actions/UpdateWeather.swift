import WeatherCommon;

public protocol UpdateWeather {
    func update(weather: Weather) async throws -> Weather;
};