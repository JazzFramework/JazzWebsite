import Foundation;

import WindmillConfiguration;
import WindmillCore;
import WindmillEventing;

import WeatherCommon;
import WeatherServer;

internal final class HelloWorldBackgroundProcess: BackgroundProcess {
    private let _config: Configuration;
    private let _eventSubscriber: EventSubscriber;
    private let _fetchAction: GetWeathers;
    private let _deleteAction: DeleteWeather;

    internal init(
        config: Configuration,
        eventSubscriber: EventSubscriber,
        fetchAction: GetWeathers,
        deleteAction: DeleteWeather
    ) {
        _config = config;
        _eventSubscriber = eventSubscriber;
        _fetchAction = fetchAction;
        _deleteAction = deleteAction;
    }

    public override func logic() async {
        _ = await _eventSubscriber.subscribe(on: "WEATHER_CREATED") { (_: Event<Weather>) in
            do {
                let weathers: [Weather] = try await self._fetchAction.get();

                if let config: BackgroundJobConfig = await self._config.fetch() {
                    print(config.setting);
                }

                print("Hello, The service currently knows of \(weathers.count) weather(s).");

                if weathers.count > 10 {
                    print("The service knows too much about the weather, and will delete all of it's knowledge.");

                    for weather in weathers {
                        try await self._deleteAction.delete(weatherId: weather.id);
                    }
                }
            }
            catch {
                print("An exception occured when trying to get the number of weathers known by the service. We'll continue to try to count because this is Weather code.");
            }
        }
    }
}