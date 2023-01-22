import WeatherCommon;

public protocol CreateWeather {
    func create(weather: Weather) async throws -> Weather;
};