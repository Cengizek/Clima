//
//  WeatherManager.swift
//  Clima
//
//  Created by Cengiz Ekmekçi on 12.10.2025.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel)
    
}

struct WeatherManager {
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=7683fabaaf288d6d1e7cfeedfa078c24&units=metric"
    
    
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        // 1. Create a URL
        if let url = URL(string: urlString){
            // 2. Create Session URL
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error{
                    
                    return
                }
                
                if let safeData = data{
                    if  let weather =  self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        }catch{
         print(error)
            return nil
        }
            
    }
    
        
        

    
}
