//
//  WebServiceProtocol.swift
//  Weather App
//
//  Created by Kuda Zata on 30/11/2022.
//

import Foundation

///This is a protocol that the WebService will conform to so as to allow us to mock it for testing purposes
protocol WebServiceProtocol {
    func getCurrentWeather(latitude: Double?, longitude: Double?, cityName: String?, completion: @escaping (Result<CurrentWeatherResponse?, NetworkError>) -> Void)
    func getForecastWeather(latitude: Double?, longitude: Double?, cityName: String?, completion: @escaping (Result<ForecastWeatherResponse?, NetworkError>) -> Void)
}
