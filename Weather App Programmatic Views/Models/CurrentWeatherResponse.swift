//
//  CurrentWeatherResponse.swift
//  Weather App
//
//  Created by Kuda Zata on 27/11/2022.
//

import Foundation

struct CurrentWeatherResponse: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
}
