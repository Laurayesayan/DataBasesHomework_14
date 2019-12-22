//
//  AlamofireViewController.swift
//  JSONParsingHomework_12
//
//  Created by Лаура Есаян on 05.12.2019.
//  Copyright © 2019 LY. All rights reserved.
//

import UIKit

class AlamofireViewController: UIViewController {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var alamofireWeatherTableView: UITableView!
    
    var weatherDicts: [WeatherDict] = []
    var weatherForOneDay = WeatherDict()
    let name = "Moscow"
    
    override func viewWillAppear(_ animated: Bool) {
        if !WeatherPersistance.shared.isEmpty() {
            self.weatherDicts = WeatherPersistance.shared.getRecordedWeather()
            self.weatherForOneDay = self.weatherDicts.remove(at: 0)
            self.addDailyWeather()
            
            self.alamofireWeatherTableView.reloadData()
            
            WeatherPersistance.shared.deleteAllWeather()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WeatherLoader().loadWeatherWithAlamofire { weatherDict in
            self.weatherForOneDay = weatherDict
            self.addDailyWeather()
            self.recordWeather(newWeather: self.weatherForOneDay)
        }

        WeatherLoader().loadWeatherFor5DaysWithAlamofire { weatherDicts in
            self.weatherDicts = weatherDicts
            self.alamofireWeatherTableView.reloadData()

            for weather in self.weatherDicts {
                self.recordWeather(newWeather: weather)
            }
        }
        
    }
    
    func convertTime(unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let localDate = dateFormatter.string(from: date)
        
        return localDate
    }
    
    func addDailyWeather() {
        let time = weatherForOneDay.time
        let name = self.name
        let main = weatherForOneDay.main
        
        timeLabel.text = String(convertTime(unixTime: Double(time)))
        nameLabel.text = name
        humidityLabel.text = String(main.humidity) + " %"
        temperatureLabel.text = String(round(main.temperature - 273.15)) + " °C"
        pressureLabel.text = String(round(Double(main.pressure * 100) / 133.322)) + " mmHg"
        
    }
    
    func recordWeather(newWeather: WeatherDict) {
        WeatherPersistance.shared.setWeather(newWeather: newWeather)
        WeatherPersistance.shared.recordWeather()
    }

}

extension AlamofireViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDicts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlamofireCell") as! AlamofireWeatherTableViewCell

        let time = weatherDicts[indexPath.row].time
        let main = weatherDicts[indexPath.row].main

        cell.timeLabel.text = String(convertTime(unixTime: Double(time)))
        cell.nameLabel.text = name
        cell.humidityLabel.text = String(main.humidity) + " %"
        cell.temperatureLabel.text = String(round(main.temperature - 273.15)) + " °C"
        cell.pressureLabel.text = String(round(Double(main.pressure * 100) / 133.322)) + " mmHg"
        
        return cell
    }
    
}
