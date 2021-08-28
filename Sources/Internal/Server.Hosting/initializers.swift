import Server;

import ServerAuthentication;
import ServerRequestLogging;

import WeatherClient;
import WeatherServerDataAccessInMemory;
import WeatherServerActionsCreateWeather;
import WeatherServerActionsDeleteWeather;
import WeatherServerActionsGetWeather;
import WeatherServerActionsGetWeathers;
import WeatherServerActionsUpdateWeather;
import WeatherServerHelloWorldBackgroundProcess;
import WeatherServerErrorsWeatherErrorsWeatherInvalidTempErrorTranslator;
import WeatherServerHostingEndpoints;

let initializers: [Initializer] = [
    //Initializers from third party plugins.
    ServerAuthenticationInitializer(),
    ServerRequestLoggingInitializer(),

    //Initializers from other internal plugins.
    WeatherClientInitializer(),

    InMemoryWeatherRepositoryInitializer(),

    CreateWeatherActionInitializer(),
    DeleteWeatherActionInitializer(),
    GetWeatherActionInitializer(),
    GetWeathersActionInitializer(),
    UpdateWeatherActionInitializer(),

    HelloWorldBackgroundProcessInitializer(),

    WeatherInvalidTempErrorTranslatorInitializer(),

    EndpointsInitializer()
];