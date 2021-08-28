import Codec;

public class BackgroundJobConfigV1JsonCodec: JsonCodec<BackgroundJobConfig> {
    public static let SupportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "Weather.backgroundJobConfig",
                "version": "1"
            ]
        );

    public override func GetSupportedMediaType() -> MediaType {
        return BackgroundJobConfigV1JsonCodec.SupportedMediaType;
    }

    public override func EncodeJson(data: BackgroundJobConfig, for mediatype: MediaType) -> JsonObject {
        return JsonObjectBuilder()
            .With("setting", property: JsonProperty(withData: data.Setting))
            .Build();
    }

    public override func DecodeJson(
        data: JsonObject,
        for mediatype: MediaType
    ) -> BackgroundJobConfig? {
        let setting: JsonProperty = data["setting"] as! JsonProperty;

        return BackgroundJobConfig(setting.GetString());
    }
}