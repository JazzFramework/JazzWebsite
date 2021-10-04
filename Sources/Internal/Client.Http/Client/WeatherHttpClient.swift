import Foundation;

import Client;
import Configuration;
import ErrorHandling;

import WeatherCommon;
import WeatherClient;

internal class WeatherHttpClient: WeatherClient {
    private static let DefaultHostname: String = "localhost";
    private static let DefaultPort: Int = 80;

    private let _host: String;
    private let _port: Int;

    private let _errorMappers: [ErrorMapper];

    internal init(
        with config: Configuration,
        with errorMappers: [ErrorMapper]
    ) {
        /*if let clientConfig: WeatherHttpClientConfig = config.Fetch() {
            _host = clientConfig.Hostname;
            _port = clientConfig.Port;
        } else {*/
            _host = WeatherHttpClient.DefaultHostname;
            _port = WeatherHttpClient.DefaultPort;
        //}

        _errorMappers = errorMappers;
    }

    public func Create(weather: Weather) throws -> Weather {
        do {
            let url: URL = try UrlBuilder()
                .With(host: _host)
                .With(port: _port)
                .With(path: "v1")
                .With(path: "weathers")
                .Build();

            let response: ProcessableResponse = try RequestRunner()
                .For(url: url)
                .For(body: weather)
                .For(method: .post)
                .For(acceptType: WeatherV1JsonCodec.SupportedMediaType)
                .Run();

            return try ResponseProcessor()
                .Ensure(statusCode: 200)
                .Process(response: response);
        } catch {
            throw Map(error: error);
        }
    }

    public func Update(weather: Weather) throws -> Weather {
        do {
            let url: URL = try UrlBuilder()
                .With(host: _host)
                .With(port: _port)
                .With(path: "v1")
                .With(path: "weathers")
                .Build();

            let response: ProcessableResponse = try RequestRunner()
                .For(url: url)
                .For(body: weather)
                .For(method: .put)
                .For(acceptType: WeatherV1JsonCodec.SupportedMediaType)
                .Run();

            return try ResponseProcessor()
                .Ensure(statusCode: 200)
                .Process(response: response);
        } catch {
            throw Map(error: error);
        }
    }

    public func GetWeather(id: String) throws -> Weather {
        do {
            let url: URL = try UrlBuilder()
                .With(host: _host)
                .With(port: _port)
                .With(path: "v1")
                .With(path: "weathers")
                .With(path: id)
                .Build();

            let response: ProcessableResponse = try RequestRunner()
                .For(url: url)
                .For(method: .get)
                .For(acceptType: WeatherV1JsonCodec.SupportedMediaType)
                .Run();

            return try ResponseProcessor()
                .Ensure(statusCode: 200)
                .Process(response: response);
        } catch {
            throw Map(error: error);
        }
    }

    public func GetWeathers() throws -> [Weather] {
        do {
            let url: URL = try UrlBuilder()
                .With(host: _host)
                .With(port: _port)
                .With(path: "v1")
                .With(path: "weathers")
                .Build();

            let response: ProcessableResponse = try RequestRunner()
                .For(url: url)
                .For(method: .get)
                .For(acceptType: WeatherCollectionV1JsonCodec.SupportedMediaType)
                .Run();

            return try ResponseProcessor()
                .Ensure(statusCode: 200)
                .Process(response: response);
        } catch {
            throw Map(error: error);
        }
    }

    public func DeleteWeather(id: String) throws {
        do {
            let url: URL = try UrlBuilder()
                .With(host: _host)
                .With(port: _port)
                .With(path: "v1")
                .With(path: "weathers")
                .With(path: id)
                .Build();

            let response: ProcessableResponse = try RequestRunner()
                .For(url: url)
                .For(method: .delete)
                .Run();

            return try ResponseProcessor()
                .Ensure(statusCode: 204)
                .Process(response: response);
        } catch {
            throw Map(error: error);
        }
    }

    private func Map(error: Error) -> Error {
        for errorMapper in _errorMappers {
            if errorMapper.CanMap(error: error) {
                return errorMapper.Map(error: error);
            }
        }

        return error;
    }
}