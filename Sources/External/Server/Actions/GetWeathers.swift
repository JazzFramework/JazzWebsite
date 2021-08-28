import WeatherCommon;

public protocol GetWeathers {
    func Get() throws -> [Weather];
};