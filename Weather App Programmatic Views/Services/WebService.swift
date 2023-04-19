//
//  WebService.swift
//  Weather App
//
//  Created by Kuda Zata on 27/11/2022.
//

import Foundation

/// The class responsible for all network calls within the app
final class WebService: WebServiceProtocol {
    
    /// Generic network caller that can take in and return any type of object
    /// - Parameters:
    ///    - resource: object of type Resource to be used for the network call
    ///    - completion: Code to be executed by the caller. Will contain type Result
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T?, NetworkError>) -> Void) {
        
        guard let url = URL(string: resource.urlString) else {
            completion(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.customError(error)))
                    return
                }
                
                if (response as? HTTPURLResponse)?.statusCode != 200 {
                    completion(.failure(.badRequest))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                completion(.success(resource.parse(data)))
            }
            
        }.resume()
    }
    
    
    /// Fetch the current weather for a given location or city name
    /// - Parameters:
    ///   - location: A CLLocation object containing the current location of the device
    ///   - completion: Callback with either the current weather resource or a Network Error
    func getCurrentWeather(latitude: Double?, longitude: Double?, cityName: String?, completion: @escaping (Result<CurrentWeatherResponse?, NetworkError>) -> Void) {
        
        var url = ""
        
        if let latitude = latitude, let longitude = longitude {
            url = Urls.currentWeatherByCoordinates(latitude: latitude, longitude: longitude)
        }
        else if let cityName = cityName {
            url = Urls.currentWeatherByCity(cityName: cityName)
        }
        
        if url == "" {
            completion(.failure(.badUrl))
            return
        }
        
        let resource = Resource<CurrentWeatherResponse>(urlString: url) { data in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let weatherResponse = try? decoder.decode(CurrentWeatherResponse.self, from: data)
            return weatherResponse
        }
        
        load(resource: resource) { result in
            switch result {
            case let .success(currentWeatherResponse):
                completion(.success(currentWeatherResponse))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    /// Fetch the forecast weather for a given location or city name
    /// - Parameters:
    ///   - location: A CLLocation object containing the current location of the device
    ///   - completion: Callback with either the forecast weather resource or a Network Error
    func getForecastWeather(latitude: Double?, longitude: Double?, cityName: String?, completion: @escaping (Result<ForecastWeatherResponse?, NetworkError>) -> Void) {
        
        var url = ""
        
        if let latitude = latitude, let longitude = longitude {
            url = Urls.forecastWeatherByCoordinates(latitude: latitude, longitude: longitude)
        }
        else if let cityName = cityName {
            url = Urls.forecastWeatherByCity(cityName: cityName)
        }
        
        if url == "" {
            completion(.failure(.badUrl))
            return
        }
        
        let resource = Resource<ForecastWeatherResponse>(urlString: url) { data in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.setDateDecodingStrategy()
            let forecastWeatherResponse = try? decoder.decode(ForecastWeatherResponse.self, from: data)
            return forecastWeatherResponse
        }
        
        load(resource: resource) { result in
            switch result {
            case let .success(forecastWeatherResponse):
                completion(.success(forecastWeatherResponse))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
