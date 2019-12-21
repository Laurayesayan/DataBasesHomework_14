//
//  Persistance.swift
//  DataBasesHomework_14
//
//  Created by Лаура Есаян on 12.12.2019.
//  Copyright © 2019 LY. All rights reserved.
//

import Foundation
import RealmSwift

class UserDefaultsPersistance {
    static let shared = UserDefaultsPersistance()
    
    private let kUserFirstNameKey = "UserDefaultsPersistance.kUserFirstNameKey"
    private let kUserSecondNameKey = "UserDefaultsPersistance.kUserSecondNameKey"
    
    var firstName: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: kUserFirstNameKey)
        } get {
            UserDefaults.standard.string(forKey: kUserFirstNameKey)
        }
    }
    
    var secondName: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: kUserSecondNameKey)
        } get {
            UserDefaults.standard.string(forKey: kUserSecondNameKey)
        }
    }
}

class Tasks: Object {
    @objc dynamic var task = ""
}

class RealmPersistance {
    static let shared = RealmPersistance()
    private var newTask = ""
    private var tasksList: [String] = []
    
    private let realm = try! Realm()
    
    func getRecoordedTask() -> [String] {
        tasksList = []
        for t in realm.objects(Tasks.self) {
            tasksList.append(t.task)
        }
        
        return tasksList.reversed()
    }
    
    func setTask(newTask: String) {
        self.newTask = newTask
    }

    func recordTask() {
        try! realm.write {
            let task = Tasks()
            task.task = newTask
            realm.add(task)
        }
    }
    
    func deleteTask(toDelete: String) {
        for task in realm.objects(Tasks.self) {
            if toDelete == task.task {
                try! realm.write {
                    realm.delete(task)
                }
            }
        }
        
        tasksList = []
    }
}

//class Main: Object {
//    @objc dynamic var temperature = Double()
//    @objc dynamic var pressure = Int64()
//    @objc dynamic var humidity = Int64()
//}
//
//class Time: Object {
//    @objc dynamic var time = Int64()
//}

class Weather: Object {
    @objc dynamic var temperature = Double()
    @objc dynamic var pressure = Int64()
    @objc dynamic var humidity = Int64()
    @objc dynamic var time = Int64()
}

class WeatherPersistance {
    static let shared = WeatherPersistance()
    private var weatherDict = [WeatherDict]()
    private var newWeatherDict = WeatherDict()
    
    private let realm = try! Realm()
    
    func setWeather(newWeather: WeatherDict) {
        self.newWeatherDict = newWeather
    }
    
    func recordWeather() {
        try! realm.write {
            let weather = Weather()
            weather.humidity = newWeatherDict.main.humidity
            weather.pressure = newWeatherDict.main.pressure
            weather.temperature = newWeatherDict.main.temperature
            weather.time = newWeatherDict.time
            
            realm.add(weather)
        }
        
    }
    
    func getRecordedWeather() -> [WeatherDict] {
        weatherDict = []
        
        for weather in realm.objects(Weather.self) {
            weatherDict.append(WeatherDict(time: weather.time, temperature: weather.temperature, pressure: weather.pressure, humidity: weather.humidity))
        }

        return weatherDict
    }
    
    func deleteAllWeather() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}
