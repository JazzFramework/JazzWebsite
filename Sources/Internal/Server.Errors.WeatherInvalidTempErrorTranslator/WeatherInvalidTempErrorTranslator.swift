import WindmillServer;

import WeatherServer;

internal class WeatherInvalidTempErrorTranslator: ErrorTranslator {
    public override func canHandle(error: Error) -> Bool {
        if case WeatherErrors.invalidTemp = error {
            return true;
        }

        return false;
    }

    public override func translate(error: Error) -> ApiError {
        switch(error) {
            case WeatherErrors.invalidTemp(let reason):
                return ApiError(
                    withCode: 400,
                    withTitle: "Invalid Temp",
                    withDetails: "\(reason)",
                    withMetadata: [
                        "reason": reason
                    ]
                );

            default:
                return buildUnknownError();
        }
    }
}