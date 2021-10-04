import Codec;

internal class WeatherHttpClientConfigV1JsonCodec: JsonCodec<WeatherHttpClientConfig> {
    private static let DefaultPort: Int = 80;

    internal static let SupportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "weather.client.httpconfig",
                "version": "1"
            ]
        );

    public override func GetSupportedMediaType() -> MediaType {
        return WeatherHttpClientConfigV1JsonCodec.SupportedMediaType;
    }

    public override func EncodeJson(data: WeatherHttpClientConfig, for mediatype: MediaType) async -> JsonObject {
        return JsonObjectBuilder()
            .With("hostname", property: JsonProperty(withData: data.Hostname))
            .With("port", property: JsonProperty(withData: data.Port))
            .Build();
    }

    public override func DecodeJson(
        data: JsonObject,
        for mediatype: MediaType
    ) async -> WeatherHttpClientConfig? {
        let hostname: JsonProperty = data["hostname"] as! JsonProperty;
        let port: JsonProperty = data["port"] as! JsonProperty;

        return WeatherHttpClientConfig(hostname.GetString(), port.GetInteger() ?? WeatherHttpClientConfigV1JsonCodec.DefaultPort);
    }
}