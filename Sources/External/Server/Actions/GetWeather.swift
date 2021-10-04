import WeatherCommon;

public protocol GetWeather {
    func Get(weatherId: String) async throws -> Weather;
};