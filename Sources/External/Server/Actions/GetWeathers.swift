import WeatherCommon;

public protocol GetWeathers {
    func Get() async throws -> [Weather];
};