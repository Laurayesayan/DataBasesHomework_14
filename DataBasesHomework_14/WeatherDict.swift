//
//  WeatherDict.swift
//  JSONParsingHomework_12
//
//  Created by Лаура Есаян on 30.11.2019.
//  Copyright © 2019 LY. All rights reserved.
//

import Foundation

struct WeatherDict {
    
    let main: Main
    let time: Int64
    
    struct Main {
        let temperature: Double
        let pressure: Int64
        let humidity: Int64
        
        init?(data: NSDictionary) {
            guard let temperature = data["temp"] as? Double,
                let pressure = data["pressure"] as? Int64,
                let humidity = data["humidity"] as? Int64 else{
                    return nil
            }
            self.temperature = temperature
            self.pressure = pressure
            self.humidity = humidity
        }
        
        init() {
            self.temperature = 0.0
            self.humidity = 0
            self.pressure = 0
        }
        
        init(_ temperature: Double, _ pressure: Int64, _ humidity: Int64) {
            self.temperature = temperature
            self.pressure = pressure
            self.humidity = humidity
        }
    }
    
    
    init?(data: NSDictionary) {
        guard let main = Main(data: data["main"] as! NSDictionary),
            let time = data["dt"] as? Int64 else{
                return nil
        }
        self.main = main
        self.time = time
    }
    
    init() {
        self.main = Main()
        self.time = 0
    }
    
    init(time: Int64, temperature: Double, pressure: Int64, humidity: Int64) {
        self.main = Main(temperature, pressure, humidity)
        self.time = time
    }
    
}
    

//class WeatherDict {
//    let temperature: Double
//    let pressure: Double
//    let humidity: Int
//
//    init?(data: NSDictionary) {
//        guard let temperature = data["temp"] as? Double,
//        let pressure = data["pressure"] as? Double,
//        let humidity = data["humidity"] as? Int else{
//            return nil
//        }
//
//        self.temperature = temperature
//        self.pressure = pressure
//        self.humidity = humidity
//    }
//}


//{
//    "coord": {
//        "lon": 37.62,
//        "lat": 55.75
//    },
//    "weather": [
//        {
//            "id": 803,
//            "main": "Clouds",
//            "description": "broken clouds",
//            "icon": "04n"
//        }
//    ],
//    "base": "stations",
//    "main": {
//        "temp": 274.77,  //temperature in Kelvins. I need to recalculate it: round(temp - 273.15)
//        "pressure": 1001, // Atmospheric pressure in hectoPascals equals to Pa * 100 -> mmhg = Pa / 133.322
//        "humidity": 100, // Влажность в %
//        "temp_min": 274.15, //min temperature in Kelvins. I need to recalculate it: round(temp - 273.15)
//        "temp_max": 275.37 //max temperature in Kelvins. I need to recalculate it: round(temp - 273.15)
//    },
//    "visibility": 10000, in meters -> km = visibility / 1000
//    "wind": {
//        "speed": 2, meter/sec
//        "deg": 240 degrees (meteorological)
//    },
//    "clouds": {
//        "all": 75 Cloudiness, %
//    },
//    "dt": 1575133470, Time of data calculation, unix, UTC:        let unixTimestamp = 1575133470.0
//                                                                  let date = Date(timeIntervalSince1970: unixTimestamp)
//    "sys": {
//        "type": 1,
//        "id": 9029,
//        "country": "RU",
//        "sunrise": 1575091952,  Sunrise time, unix, UTC the same with dt
//        "sunset": 1575119033 Sunset time,  unix, UTC the same with dt
//    },
//    "timezone": 10800,
//    "id": 524901,
//    "name": "Moscow", city name
//    "cod": 200
//}
