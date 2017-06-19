//
//  HistoryViewController.swift
//  WeatherApp
//
//  Created by Admin on 14/06/2017.
//  Copyright © 2017 da_manifest. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    private let ROW_HEIGHT: CGFloat = 60
    var weatherList = [WeatherData]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = ROW_HEIGHT
        tableView.tableFooterView = UIView()
        
        let dataManager = WeatherDataManager()
        weatherList = dataManager.loadData()
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        }
        else
        {
            cell.backgroundColor = UIColor.clear
        }

        if let cityName = weatherList[indexPath.row].cityName,
            let weatherDescription = weatherList[indexPath.row].weatherDescription
        {
            let temperature = weatherList[indexPath.row].temperature
            let humidity = weatherList[indexPath.row].humidity
            let windSpeed = weatherList[indexPath.row].windSpeed
            cell.textLabel?.text = String(format: "\(cityName): \(weatherDescription) \n%.0f°, %.0f%%, %.0f м/с", temperature, humidity, windSpeed)
            
        }
        if let date = weatherList[indexPath.row].dateCreated
        {
            let formattedDate = dateFormatted("\(date)")
            cell.detailTextLabel?.text = formattedDate
        }
        
        return cell
    }
    
    func dateFormatted(_ str: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let dateFromStr = dateFormatter.date(from: str)!
        
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd HH:mm:ss", options: 0, locale: NSLocale.current)
        let strFromDate = dateFormatter.string(from: dateFromStr)
        
        return strFromDate
    }
}
