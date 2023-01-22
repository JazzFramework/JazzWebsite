import WeatherCommon;

public protocol GetWeathers {
    func get() async throws -> [Weather];
};