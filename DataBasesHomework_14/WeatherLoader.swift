import UIKit
import Alamofire

class WeatherLoader {
    
    func loadWeather(completion: @escaping (WeatherDict) -> Void){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Moscow,ru&APPID=25d13511e3a337c6eb628b9c5dc086bf")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary {
                if let weatherDict = WeatherDict(data: jsonDict){
                    DispatchQueue.main.async {
                        completion(weatherDict)
                    }
                }
            }
        }
        task.resume()
    }
    
    func loadFiveDaysWeather(completion: @escaping ([WeatherDict]) -> Void){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=Moscow,ru&APPID=25d13511e3a337c6eb628b9c5dc086bf")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary {
                if let jsonDictList = jsonDict["list"] as? NSArray {
                    var weatherDicts: [WeatherDict] = []
                    for data in jsonDictList {
                        if let data = data as? NSDictionary {
                            if let weatherDict = WeatherDict(data: data){
                                weatherDicts.append(weatherDict)
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completion(weatherDicts)
                    }
                }
                
            }
        }
        task.resume()
    }
    
    func loadWeatherWithAlamofire(completion: @escaping (WeatherDict) -> Void) {
        AF.request("https://api.openweathermap.org/data/2.5/weather?q=Moscow,ru&APPID=25d13511e3a337c6eb628b9c5dc086bf").responseJSON {
            response in
            if let json = response.value,
                let jsonDict = json as? NSDictionary {
                    if let weatherDict = WeatherDict(data: jsonDict){
                        DispatchQueue.main.async {
                            completion(weatherDict)
                        }
                    }
                }
            
        }
    }
    
    func loadWeatherFor5DaysWithAlamofire(completion: @escaping ([WeatherDict]) -> Void) {
        AF.request("https://api.openweathermap.org/data/2.5/forecast?q=Moscow,ru&APPID=25d13511e3a337c6eb628b9c5dc086bf").responseJSON {
            response in
            if let json = response.value,
                let jsonDict = json as? NSDictionary {
                if let jsonDictList = jsonDict["list"] as? NSArray {
                    var weatherDicts: [WeatherDict] = []
                    for data in jsonDictList {
                        if let data = data as? NSDictionary {
                            if let weatherDict = WeatherDict(data: data){
                                weatherDicts.append(weatherDict)
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completion(weatherDicts)
                    }
                }
                
            }
            
        }
    }
    
    
    
}


