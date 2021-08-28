import Foundation;

import Configuration;
import Server;
import ServerNio;

try AppRunner(
    withApp:
        try AppBuilder()
            .With(httpProcessor: HummingbirdHttpProcessor())
            .Build(),

    withInitializers: [
        //Initializers from third party plugins.
        "ServerAuthentication.ServerAuthenticationInitializer",
        "ServerRequestLogging.ServerRequestLoggingInitializer",

        //Initializers from other internal plugins.
        "WeatherCommon.WeatherCodecsInitializer",

        "WeatherServerDataAccessInMemory.InMemoryWeatherRepositoryInitializer",

        "WeatherServerActionsCreateWeather.CreateWeatherActionInitializer",
        "WeatherServerActionsDeleteWeather.DeleteWeatherActionInitializer",
        "WeatherServerActionsGetWeather.GetWeatherActionInitializer",
        "WeatherServerActionsGetWeathers.GetWeathersActionInitializer",
        "WeatherServerActionsUpdateWeather.UpdateWeatherActionInitializer",

        "WeatherServerHelloWorldBackgroundProcess.HelloWorldBackgroundProcessInitializer",

        "WeatherServerErrorsWeatherErrorsWeatherInvalidTempErrorTranslator.WeatherInvalidTempErrorTranslatorInitializer",
        "WeatherServerHostingEndpoints.EndpointsInitializer"
    ],

    withConfiguration: 
        ConfigurationBuilder()
            .With(bundle: Bundle.module)
)
    .Run();