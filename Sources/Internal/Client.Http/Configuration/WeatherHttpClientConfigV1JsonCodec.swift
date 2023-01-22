import WindmillCodec;

internal class WeatherHttpClientConfigV1JsonCodec: JsonCodec<WeatherHttpClientConfig> {
    private static let defaultPort: Int = 80;

    internal static let supportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "weather.client.httpconfig",
                "version": "1"
            ]
        );

    public override func getSupportedMediaType() -> MediaType {
        return WeatherHttpClientConfigV1JsonCodec.supportedMediaType;
    }

    public override func encodeJson(data: WeatherHttpClientConfig, for mediatype: MediaType) async -> JsonObject {
        return JsonObjectBuilder()
            .with("hostname", property: JsonProperty(withData: data.Hostname))
            .with("port", property: JsonProperty(withData: data.Port))
            .build();
    }

    public override func decodeJson(
        data: JsonObject,
        for mediatype: MediaType
    ) async -> WeatherHttpClientConfig? {
        let hostname: JsonProperty = data["hostname"] as! JsonProperty;
        let port: JsonProperty = data["port"] as! JsonProperty;

        return WeatherHttpClientConfig(hostname.getString(), port.getInteger() ?? WeatherHttpClientConfigV1JsonCodec.defaultPort);
    }
}