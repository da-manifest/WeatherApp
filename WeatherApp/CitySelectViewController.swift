//
//  CitySelectViewController.swift
//  WeatherApp
//
//  Created by Admin on 14/06/2017.
//  Copyright © 2017 da_manifest. All rights reserved.
//

import UIKit
import Foundation

class CitySelectViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func searchButtonAction(_ sender: UIButton)
    {
        let activityIndicator = ActivityIndicator()
        activityIndicator.showActivity(self.view)
        let apiWorker = WeatherAPIWorker()
        if let cityName = textField.text
        {
            apiWorker.getWeatherForCity(cityName)
            {
                result in
                activityIndicator.removeActivity(self.view)
                
                switch result
                {
                case .success(result: let r):
                    if cityName.caseInsensitiveCompare(r.cityName) == ComparisonResult.orderedSame
                    {
                        UserDefaults.standard.set(cityName, forKey: "selectedCity")
                        self.navigationController?.popViewController(animated: true)
                        
                        let weatherData = ["weatherData" : r]
                        NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationKeys.didFoundCityKey), object: nil, userInfo: weatherData)
                    }
                    else
                    {
                        fireAlert(title: AlertMessages.ErrorTitle, message: AlertMessages.SearchCityError)
                    }
                    
                case .error(error: let e):
                    fireAlert(title: AlertMessages.ErrorTitle, message: e.localizedDescription)
                }
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        textField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        dismissKeyboard()
        return false
    }
    
    @objc private func dismissKeyboard()
    {
        textField.resignFirstResponder()
    }
}
