import Foundation;

import WindmillConsole;

import WeatherCommon;
import WeatherServer;

public final class Entrypoint: ConsoleAppEntrypoint {
    private let createWeather: CreateWeather;

    internal init(createWeather: CreateWeather) {
        self.createWeather = createWeather;
    }

    public func start() async throws {
        _ = try await createWeather.create(weather: Weather("", "1"))

        try await Task.sleep(nanoseconds: UInt64(2 * Double(NSEC_PER_SEC)));

        print("app");
    }
}