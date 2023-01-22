import WeatherCommon;

public protocol GetWeather {
    func get(weatherId: String) async throws -> Weather;
};