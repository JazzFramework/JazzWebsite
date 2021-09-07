import ErrorHandling;

import WeatherCommon;

internal class WeatherHttpClientErrorMapper: ErrorMapper {
    public override func CanMap(error: Error) -> Bool {
        return true;
    }

    public override func Map(error: Error) -> Error {
        return error;
    }
}