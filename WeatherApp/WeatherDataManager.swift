//
//  WeatherDataManager.swift
//  WeatherApp
//
//  Created by Admin on 14/06/2017.
//  Copyright © 2017 da_manifest. All rights reserved.
//

import SwiftyJSON
import CoreData

class WeatherDataManager
{
    func saveData(_ weatherData: WeatherDataEntity, dateCreated: Date)
    {
        if #available(iOS 10.0, *)
        {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let data = WeatherData(context: context)
            data.cityName = weatherData.cityName
            data.temperature = weatherData.temperature
            data.weatherDescription = weatherData.weatherDescription
            data.humidity = weatherData.humidity
            data.windSpeed = weatherData.windSpeed
            data.dateCreated = dateCreated as NSDate
        }
        else
        {
            let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
            
            if let entityDescription =
                NSEntityDescription.entity(forEntityName: "WeatherData", in: context)
            {
                let data = WeatherData(entity: entityDescription, insertInto: context)
                data.cityName = weatherData.cityName
                data.temperature = weatherData.temperature
                data.weatherDescription = weatherData.weatherDescription
                data.humidity = weatherData.humidity
                data.windSpeed = weatherData.windSpeed
                data.dateCreated = dateCreated as NSDate
            }
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func loadData() -> [WeatherData]
    {
        var weatherDataList = [WeatherData]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherData")
        let sort = NSSortDescriptor(key: "dateCreated", ascending: false)
        request.sortDescriptors = [sort]

        if #available(iOS 10.0, *)
        {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            do
            {
                weatherDataList = try context.fetch(request) as! [WeatherData]
            }
            catch
            {
                print("Fetching Failed")
            }
        }
        else
        {
            let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
            do
            {
                weatherDataList = try context.fetch(request) as! [WeatherData]
            }
            catch
            {
                print("Fetching Failed")
            }
        }
        return weatherDataList
    }
}
