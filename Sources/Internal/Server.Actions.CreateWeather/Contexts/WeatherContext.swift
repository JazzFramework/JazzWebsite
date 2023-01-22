import WindmillContext

import WeatherCommon;

internal final class WeatherContext: BaseContext {
    internal let value: Weather;

    internal init(_ value: Weather) {
        self.value = value;
    }
}