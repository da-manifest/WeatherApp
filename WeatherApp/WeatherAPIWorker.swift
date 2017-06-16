//
//  WeatherAPIWorker.swift
//  WeatherApp
//
//  Created by Admin on 14/06/2017.
//  Copyright © 2017 da_manifest. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherAPIWorker
{
    func getWeatherForCoordinates(latitude: String, longitude: String, completion:  @escaping (APIResultType) -> ())
    {
        var url = AppURLList.coordinatesWeatherURL.replacingOccurrences(of: URLPlaceholders.LATITUDE_PLACEHOLDER, with: "\(latitude)")
        url = url.replacingOccurrences(of: URLPlaceholders.LONGITUDE_PLACEHOLDER, with: "\(longitude)")
        
        getWeatherData(fromURL: url)
        {
            result in
            DispatchQueue.main.async
                {
                    completion(result)
            }
        }
    }
    
    func getWeatherForCity(_ cityName: String, completion: @escaping (APIResultType) -> ())
    {
        let url = AppURLList.cityWeatherURL.replacingOccurrences(of: URLPlaceholders.CITY_NAME_PLACEHOLDER, with: cityName)
        
        getWeatherData(fromURL: url)
        {
            result in
            DispatchQueue.main.async
                {
                    completion(result)
            }
        }
    }
    
    private func getWeatherData(fromURL url: String, completion: @escaping (APIResultType) -> ())
    {
        DispatchQueue.global(qos: .utility).async
            {
                let httpHelper = HTTPHelper()
                httpHelper.makeRequest(url)
                {
                    result in
                    if httpHelper.error == nil
                    {
                        print("API request complete successfully")
                        let weatherDataEntity = self.parseJSON(httpHelper.responseJSON)
                        completion(APIResultType.success(result: weatherDataEntity))
                    }
                    else
                    {
                        print("API request failed with error")
                        completion(APIResultType.error(error: httpHelper.error!))
                    }
                }
        }
    }
    
    private func parseJSON(_ json: JSON) -> WeatherDataEntity
    {
        var weatherDataEntity = WeatherDataEntity(cityName: "",
                                                  temperature: 0,
                                                  weatherDescription: "",
                                                  humidity: 0,
                                                  windSpeed: 0)
        
        weatherDataEntity.cityName = json["name"].stringValue
        weatherDataEntity.weatherDescription = json["weather"][0]["description"].stringValue
        weatherDataEntity.temperature = json["main"]["temp"].floatValue
        weatherDataEntity.humidity = json["main"]["humidity"].floatValue
        weatherDataEntity.windSpeed = json["wind"]["speed"].floatValue
        
        return weatherDataEntity
    }
}
