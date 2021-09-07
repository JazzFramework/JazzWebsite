import WeatherCommon;

public protocol WeatherClient {
    func Create(weather: Weather) throws -> Weather;
    func Update(weather: Weather) throws -> Weather;
    func GetWeather(id: String) throws -> Weather;
    func GetWeathers() throws -> [Weather];
    func DeleteWeather(id: String) throws;
}