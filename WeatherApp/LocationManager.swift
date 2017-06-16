//
//  LocationManager.swift
//  CallRecorder
//
//  Created by Admin on 23.03.17.
//  Copyright © 2017 Intehno. All rights reserved.
//


import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate
{
    var latitude = String()
    var longitude = String()
    
    private let DISTANCE_FILTER: CLLocationDistance = 10
    private let locationManager = CLLocationManager()
    
    func getCurrentLocation()
    {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = DISTANCE_FILTER
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if status == .authorizedWhenInUse || status == .authorizedAlways
        {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        locationManager.stopUpdatingLocation()
        if let latitude = locations.last?.coordinate.latitude,
            let longitude = locations.last?.coordinate.longitude
        {
            self.latitude = latitude.description
            self.longitude = longitude.description
            print("latitude \(self.latitude), longitude \(self.longitude)") //TODO: - remove
            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationKeys.didUpdateLocationsKey), object: nil)
        }
        locationManager.delegate = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        locationManager.stopUpdatingLocation()
        NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationKeys.failedUpdateLocationsKey), object: nil)
        print(error)
    }
}
