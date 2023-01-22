import WeatherCommon;

public protocol DeleteWeather {
    func delete(weatherId: String) async throws;
};