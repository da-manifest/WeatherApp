//
//  AppStructs.swift
//  WeatherApp
//
//  Created by Admin on 14/06/2017.
//  Copyright © 2017 da_manifest. All rights reserved.
//

struct WeatherDataEntity
{
    var cityName: String
    var temperature: Float
    var weatherDescription: String
    var humidity: Float
    var windSpeed: Float
}

struct APIStatus
{
    static let STATUS_OK: Int = 200
}

enum APIResultType
{
    case success(result: WeatherDataEntity)
    case error(error: Error)
}

struct NotificationKeys
{
    static let didUpdateLocationsKey = "com.weatherApp.didUpdateLocationsNotificationKey"
    static let failedUpdateLocationsKey = "com.weatherApp.failedUpdateLocationsKey"
    static let didFoundCityKey = "com.weatherApp.didFoundCityKeyNotificationKey"
}

struct AlertMessages
{
    static let TemperatureChangedTitle = "Температура изменилась"
    static let TemperatureChangedText = "Текущая температура изменилась с %.0f° до %.0f°"
    static let ErrorTitle = "Ошибка"
    static let LocationErrorText = "Не удалось определить текущее местоположение"
    static let SearchCityError = "Город не найден. Попробуйте изменить запрос."
}

struct AppURLList
{
    static let cityWeatherURL = AppURL.domainURL + AppURL.cityWeatherURL + AppURL.appID
    static let coordinatesWeatherURL = AppURL.domainURL + AppURL.coordinatesWeatherURL + AppURL.appID
}

fileprivate struct AppURL
{
    static let domainURL = "http://api.openweathermap.org/data/2.5/weather?"
    static let coordinatesWeatherURL  = "lat=\(URLPlaceholders.LATITUDE_PLACEHOLDER)&lon=\(URLPlaceholders.LONGITUDE_PLACEHOLDER)&units=metric&appid="
    static let cityWeatherURL = "q=\(URLPlaceholders.CITY_NAME_PLACEHOLDER)&units=metric&appid="
    static let appID = "11642b38f918ea6ae6702f239388c89d"
}

struct URLPlaceholders
{
    static let LATITUDE_PLACEHOLDER = "latitudePlaceholder"
    static let LONGITUDE_PLACEHOLDER = "longitudePlaceholder"
    static let CITY_NAME_PLACEHOLDER = "cityNamePlaceholder"
}
