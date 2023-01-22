import Foundation;

import WindmillClient;
import WindmillCodec;
import WindmillConfiguration;

import WeatherCommon;
import WeatherClient;

internal class WeatherHttpClient: WeatherClient {
    private static let DefaultHostname: String = "localhost";
    private static let DefaultPort: Int = 80;

    private let _host: String;
    private let _port: Int;

    internal init(
        with config: Configuration
    ) {
        /*if let clientConfig: WeatherHttpClientConfig = config.Fetch() {
            _host = clientConfig.Hostname;
            _port = clientConfig.Port;
        } else {*/
            _host = WeatherHttpClient.DefaultHostname;
            _port = WeatherHttpClient.DefaultPort;
        //}
    }

    public func create(weather: Weather) throws -> Weather {
        do {
            let url: URL = try UrlBuilder()
                .with(host: _host)
                .with(port: _port)
                .with(path: "v1")
                .with(path: "weathers")
                .build();

            let response: ProcessableResponse = try RequestRunner()
                .with(url: url)
                .with(body: weather)
                .with(method: .post)
                .with(acceptType: WeatherV1JsonCodec.weatherMediaType)
                .run();

            return try ResponseProcessor()
                .ensure(statusCode: 200)
                .process(response: response);
        } catch {
            throw map(error: error);
        }
    }

    public func update(weather: Weather) throws -> Weather {
        do {
            let url: URL = try UrlBuilder()
                .with(host: _host)
                .with(port: _port)
                .with(path: "v1")
                .with(path: "weathers")
                .build();

            let response: ProcessableResponse = try RequestRunner()
                .with(url: url)
                .with(body: weather)
                .with(method: .put)
                .with(acceptType: WeatherV1JsonCodec.weatherMediaType)
                .run();

            return try ResponseProcessor()
                .ensure(statusCode: 200)
                .process(response: response);
        } catch {
            throw map(error: error);
        }
    }

    public func getWeather(id: String) throws -> Weather {
        do {
            let url: URL = try UrlBuilder()
                .with(host: _host)
                .with(port: _port)
                .with(path: "v1")
                .with(path: "weathers")
                .with(path: id)
                .build();

            let response: ProcessableResponse = try RequestRunner()
                .with(url: url)
                .with(method: .get)
                .with(acceptType: WeatherV1JsonCodec.weatherMediaType)
                .run();

            return try ResponseProcessor()
                .ensure(statusCode: 200)
                .process(response: response);
        } catch {
            throw map(error: error);
        }
    }

    public func getWeathers() throws -> [Weather] {
        do {
            let url: URL = try UrlBuilder()
                .with(host: _host)
                .with(port: _port)
                .with(path: "v1")
                .with(path: "weathers")
                .build();

            let response: ProcessableResponse = try RequestRunner()
                .with(url: url)
                .with(method: .get)
                .with(acceptType: 
                    MediaType(
                        withType: "application",
                        withSubtype: "json",
                        withParameters: [
                            "structure": "weather.weathers",
                            "version": "1"
                        ]
                    )
                )
                .run();

            return try ResponseProcessor()
                .ensure(statusCode: 200)
                .process(response: response);
        } catch {
            throw map(error: error);
        }
    }

    public func deleteWeather(id: String) throws {
        do {
            let url: URL = try UrlBuilder()
                .with(host: _host)
                .with(port: _port)
                .with(path: "v1")
                .with(path: "weathers")
                .with(path: id)
                .build();

            let response: ProcessableResponse = try RequestRunner()
                .with(url: url)
                .with(method: .delete)
                .run();

            return try ResponseProcessor()
                .ensure(statusCode: 204)
                .process(response: response);
        } catch {
            throw map(error: error);
        }
    }

    private func map(error: Error) -> Error {
        return error;
    }
}