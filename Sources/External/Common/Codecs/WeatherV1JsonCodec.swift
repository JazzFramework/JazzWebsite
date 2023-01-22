import WindmillCodec;

public class WeatherV1JsonCodec: JsonCodec<Weather> {
    public static let weatherMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "weather.weather",
                "version": "1"
            ]
        );

    public static let weathersMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "weather.weathers",
                "version": "1"
            ]
        );

    public static let collectionCodec: JsonCodec<[Weather]> =
        CollectionJsonCodec<Weather>(
            withCodec: WeatherV1JsonCodec(),
            withMediaType: WeatherV1JsonCodec.weathersMediaType
        );

    public override func getSupportedMediaType() -> MediaType {
        return WeatherV1JsonCodec.weatherMediaType;
    }

    public override func encodeJson(data: Weather, for mediatype: MediaType) async -> JsonObject {
        return JsonObjectBuilder()
            .with("id", property: JsonProperty(withData: data.id))
            .with("temp", property: JsonProperty(withData: data.temp))
            .build();
    }

    public override func decodeJson(data: JsonObject, for mediatype: MediaType) async -> Weather? {
        let id: JsonProperty = data["id"] as! JsonProperty;
        let temp: JsonProperty = data["temp"] as! JsonProperty;

        return Weather(id.getString(), temp.getString());
    }
}