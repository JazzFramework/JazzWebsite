import WindmillCodec;

internal class BackgroundJobConfigV1JsonCodec: JsonCodec<BackgroundJobConfig> {
    internal static let supportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "Weather.backgroundJobConfig",
                "version": "1"
            ]
        );

    public override func getSupportedMediaType() -> MediaType {
        return BackgroundJobConfigV1JsonCodec.supportedMediaType;
    }

    public override func encodeJson(data: BackgroundJobConfig, for mediatype: MediaType) async -> JsonObject {
        return JsonObjectBuilder()
            .with("setting", property: JsonProperty(withData: data.setting))
            .build();
    }

    public override func decodeJson(
        data: JsonObject,
        for mediatype: MediaType
    ) async -> BackgroundJobConfig? {
        let setting: JsonProperty = data["setting"] as! JsonProperty;

        return BackgroundJobConfig(setting.getString());
    }
}