//
//  ForecastWeatherItem.swift
//  Weather App
//
//  Created by Kuda Zata on 29/11/2022.
//

import Foundation

struct ForecastWeatherItem: Decodable {
    let main: Main
    let weather: [Weather]
    let dtTxt: Date
}
