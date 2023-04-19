//
//  Constants.swift
//  Weather App
//
//  Created by Kuda Zata on 28/11/2022.
//

import Foundation
import CoreLocation

struct Urls {
    
    static func currentWeatherByCoordinates(latitude: Double, longitude: Double) -> String {
        return "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=d23516d0b2787144caf23421d5ec4515&units=metric"
    }
    
    static func forecastWeatherByCoordinates(latitude: Double, longitude: Double) -> String {
        return "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=d23516d0b2787144caf23421d5ec4515&units=metric"
    }
    
    static func currentWeatherByCity(cityName: String) -> String {
        return "https://api.openweathermap.org/data/2.5/weather?q=\(cityName.escaped())&appid=d23516d0b2787144caf23421d5ec4515&units=metric"
    }
    
    static func forecastWeatherByCity(cityName: String) -> String {
        return "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName.escaped())&appid=d23516d0b2787144caf23421d5ec4515&units=metric"
    }
    
}
