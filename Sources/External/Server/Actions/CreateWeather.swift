import WeatherCommon;

public protocol CreateWeather {
    func Create(weather: Weather) async throws -> Weather;
};