import WeatherCommon;

public protocol UpdateWeather {
    func Update(weather: Weather) async throws -> Weather;
};