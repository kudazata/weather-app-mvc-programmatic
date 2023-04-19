//
//  ForecastWeatherResponse.swift
//  Weather App
//
//  Created by Kuda Zata on 28/11/2022.
//

import Foundation

struct ForecastWeatherResponse: Decodable {
    let list: [ForecastWeatherItem]
}


