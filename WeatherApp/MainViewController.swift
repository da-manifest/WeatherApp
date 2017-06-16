//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Admin on 14/06/2017.
//  Copyright © 2017 da_manifest. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UINavigationControllerDelegate
{
    private let locationManager = LocationManager()
    private let activityIndicator = ActivityIndicator()
    
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var weatherConditions: UILabel!
    @IBOutlet weak var cityName: UIButton!
    @IBOutlet weak var weatherDescription: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(requestWeatherDataForCurrentLocation),
            name: Notification.Name(rawValue: NotificationKeys.didUpdateLocationsKey),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(manageWeatherForCity),
            name: Notification.Name(rawValue: NotificationKeys.didFoundCityKey),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(fireAlertIfLocationUpdateFailed),
            name: Notification.Name(rawValue: NotificationKeys.failedUpdateLocationsKey),
            object: nil
        )
        
       updateWeather()
    }
    
    private func updateWeather()
    {
        self.activityIndicator.showActivity(self.view)
        let selectedCity = UserDefaults.standard.string(forKey: "selectedCity")
        if selectedCity != nil && selectedCity != ""
        {
            getWeatherForSelectedCity()
        }
        else
        {
            getWeatherForCurrentLocation()
        }
    }
    
    private func getWeatherForSelectedCity()
    {
        if let selectedCity = UserDefaults.standard.string(forKey: "selectedCity")
        {
            let apiWorker = WeatherAPIWorker()
            apiWorker.getWeatherForCity(selectedCity)
            {
                result in
                
                self.activityIndicator.removeActivity(self.view)
                
                switch result
                {
                case .success(result: let r):
                    self.manageWeatherData(r)
                    
                case .error(error: let e):
                    fireAlert(title: AlertMessages.ErrorTitle, message: e.localizedDescription)
                }
            }
        }
    }
    
    private func getWeatherForCurrentLocation()
    {
        self.locationManager.getCurrentLocation()
    }
    
    private func manageWeatherData(_ weatherData: WeatherDataEntity)
    {
        updateLabels(weatherData)
        
        let dataManager = WeatherDataManager()
        let currentDate = Date(timeIntervalSinceNow: 0)
        dataManager.saveData(weatherData, dateCreated: currentDate)
        
        let currentTemperature = weatherData.temperature
        self.fireAlertIfTemperatureDifferenceMoreThenThreeDegrees(currentTemperature: currentTemperature)
    }
    
    private func updateLabels(_ weatherDataEntity: WeatherDataEntity)
    {
        self.currentTemperature.text = String(format: "%.0f°", weatherDataEntity.temperature)
        weatherConditions.text = String(format: "%.0f %%   %.0f м/с", weatherDataEntity.humidity, weatherDataEntity.windSpeed)
        weatherDescription.text = weatherDataEntity.weatherDescription
        cityName.setTitle(weatherDataEntity.cityName, for: .normal)
    }
    
    private func fireAlertIfTemperatureDifferenceMoreThenThreeDegrees(currentTemperature: Float)
    {
        let dataManager = WeatherDataManager()
        let weatherDataList = dataManager.loadData()
        
        if let previousTemperature = weatherDataList.first?.temperature
        {
            if (previousTemperature > currentTemperature) &&
                (fabsf(currentTemperature - previousTemperature) > 3)
            {
                let localNotification = UILocalNotification()
                localNotification.fireDate = Date(timeIntervalSinceNow: 0)
                localNotification.timeZone = NSTimeZone.default
                localNotification.alertTitle = AlertMessages.TemperatureChangedTitle
                localNotification.alertBody = String(format: AlertMessages.TemperatureChangedText, previousTemperature, currentTemperature)
                UIApplication.shared.scheduleLocalNotification(localNotification)
            }
        }
    }
    

    
    @objc private func fireAlertIfLocationUpdateFailed()
    {
        fireAlert(title: AlertMessages.ErrorTitle, message: AlertMessages.LocationErrorText)
        activityIndicator.removeActivity(self.view)
    }
    
    @objc private func manageWeatherForCity(notification: Notification)
    {
        if let weatherData = notification.userInfo?["weatherData"] as? WeatherDataEntity
        {
            manageWeatherData(weatherData)
        }
    }
    
    @objc private func requestWeatherDataForCurrentLocation()
    {
        let apiWorker = WeatherAPIWorker()
        apiWorker.getWeatherForCoordinates(latitude: self.locationManager.latitude, longitude: locationManager.longitude)
        {
            result in
            
            self.activityIndicator.removeActivity(self.view)
            
            switch result
            {
            case .success(result: let r):
                self.manageWeatherData(r)
            case .error(error: let e):
                fireAlert(title: AlertMessages.ErrorTitle, message: e.localizedDescription)
            }
        }
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
}
