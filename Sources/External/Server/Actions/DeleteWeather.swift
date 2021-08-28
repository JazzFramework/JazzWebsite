import WeatherCommon;

public protocol DeleteWeather {
    func Delete(weatherId: String) throws;
};