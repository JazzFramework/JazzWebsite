import Codec;

public class WeatherV1JsonCodec: JsonCodec<Weather> {
    public static let SupportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "weather.weather",
                "version": "1"
            ]
        );

    public override func GetSupportedMediaType() -> MediaType {
        return WeatherV1JsonCodec.SupportedMediaType;
    }

    public override func EncodeJson(data: Weather, for mediatype: MediaType) async -> JsonObject {
        return JsonObjectBuilder()
            .With("id", property: JsonProperty(withData: data.Id))
            .With("temp", property: JsonProperty(withData: data.Temp))
            .Build();
    }

    public override func DecodeJson(data: JsonObject, for mediatype: MediaType) async -> Weather? {
        let id: JsonProperty = data["id"] as! JsonProperty;
        let temp: JsonProperty = data["temp"] as! JsonProperty;

        return Weather(id.GetString(), temp.GetString());
    }
}