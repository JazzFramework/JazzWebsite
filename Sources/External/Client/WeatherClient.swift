import WeatherCommon;

public protocol WeatherClient {
    func create(weather: Weather) throws -> Weather;
    func update(weather: Weather) throws -> Weather;
    func getWeather(id: String) throws -> Weather;
    func getWeathers() throws -> [Weather];
    func deleteWeather(id: String) throws;
}