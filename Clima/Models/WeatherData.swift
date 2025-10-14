//
//  WeatherData.swift
//  Clima
//
//  Created by Cengiz Ekmekçi on 12.10.2025.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main :Main
    let weather: [Weather]
   
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id : Int
}
