internal class WeatherHttpClientConfig {
    internal let Hostname: String;
    internal let Port: Int;

    internal init(_ hostname: String, _ port: Int)
    {
        Hostname = hostname;
        Port = port;
    };
}