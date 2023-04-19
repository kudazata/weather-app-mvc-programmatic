//
//  MainWeatherViewController.swift
//  Weather App Programmatic Views
//
//  Created by Kuda Zata on 19/4/2023.
//

import UIKit
import CoreLocation

class MainWeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cityNameLabel = UILabel()
    var currentTempLabel = UILabel()
    var currentConditionLabel = UILabel()
    var imageView = UIImageView()
    var tableView = UITableView()
    var webService: WebServiceProtocol = WebService()
    var location: CLLocationCoordinate2D!
    var didFetchLocation = false
    let locationManager = CLLocationManager()
    
    private var forecastWeatherItems = [ForecastWeatherItem]()
    private var currentWeather: CurrentWeatherResponse?
    
    /// Dispatch group for the multiple network calls for fetching current and forecast weather
    private var dispatchGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func setupViews() {
        
        self.view.backgroundColor = UIColor(rgb: 0x47AB2F)
       
        self.view.addSubview(imageView)
        self.view.addSubview(tableView)
        tableView.backgroundColor = .clear
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        
        let imageViewTopConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let imageViewLeadingConstraint = NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let imageViewTrailingConstraint = NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let imageViewHeightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 285)
        
        self.view.addConstraints([imageViewTopConstraint, imageViewLeadingConstraint, imageViewTrailingConstraint])
        imageView.addConstraint(imageViewHeightConstraint)
        
        let bottomConstraint = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 10)
        let leftConstraint = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        
        self.view.addConstraints([bottomConstraint, topConstraint, leftConstraint, rightConstraint])
        
        cityNameLabel = UILabel()
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        cityNameLabel.textColor = .white
        cityNameLabel.text = "--"
        self.view.addSubview(cityNameLabel)
        
        let cityLabelTopConstraint = NSLayoutConstraint(item: cityNameLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 20)
        let cityLabelCentreXConstraint = NSLayoutConstraint(item: cityNameLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        self.view.addConstraints([cityLabelTopConstraint, cityLabelCentreXConstraint])
        
        
        currentTempLabel = UILabel()
        currentTempLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTempLabel.font = .systemFont(ofSize: 45, weight: .bold)
        currentTempLabel.textColor = .white
        currentTempLabel.text = "--°"
        self.view.addSubview(currentTempLabel)
        
        let currentTempLabelTopConstraint = NSLayoutConstraint(item: currentTempLabel, attribute: .top, relatedBy: .equal, toItem: cityNameLabel, attribute: .bottom, multiplier: 1, constant: 0)
        let currentTempLabelCentreXConstraint = NSLayoutConstraint(item: currentTempLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        self.view.addConstraints([currentTempLabelTopConstraint, currentTempLabelCentreXConstraint])
        
        currentConditionLabel = UILabel()
        currentConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        currentConditionLabel.font = .systemFont(ofSize: 28, weight: .bold)
        currentConditionLabel.textColor = .white
        currentConditionLabel.text = "--"
        self.view.addSubview(currentConditionLabel)
        
        let currentConditionLabelTopConstraint = NSLayoutConstraint(item: currentConditionLabel, attribute: .top, relatedBy: .equal, toItem: currentTempLabel, attribute: .bottom, multiplier: 1, constant: 0)
        let currentConditionLabelCentreXConstraint = NSLayoutConstraint(item: currentConditionLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        self.view.addConstraints([currentConditionLabelTopConstraint, currentConditionLabelCentreXConstraint])
        
        tableView.register(DailyTemperatureCell.self, forCellReuseIdentifier: "weatherCell")
        tableView.dataSource = self
        tableView.delegate = self
        imageView.image = UIImage(named: "forest_sunny")
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastWeatherItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as! DailyTemperatureCell
        cell.configureCell(forecastWeather: forecastWeatherItems[indexPath.row])
        return cell
    }
    
    private func updateWeatherInfo() {
        if let currentWeather = currentWeather {
            cityNameLabel.text = currentWeather.name
            currentTempLabel.text = currentWeather.main.temp.toStringWithZeroDecimalPlaces() + "°"
            
            let condition = CurrentCondition(rawValue: currentWeather.weather[0].main)
            currentConditionLabel.text = condition?.displayName
            self.view.backgroundColor = UIColor(rgb: condition?.backgroundColorHexValue ?? 0x47AB2F)
            self.imageView.image = UIImage(named: condition?.backgroundImageName ?? "forest_sunny")
                
            self.tableView.reloadData()
        }
    }
    
    
    //MARK: - NETWORK FUNCTIONS
    
    func getWeatherInfoByCoordinates(latitude: Double, longitude: Double) {
        
        getCurrentWeatherByCoordinates(latitude: latitude, longitude: longitude)
        getForecastWeatherByCoordinates(latitude: latitude, longitude: latitude)
        
        self.dispatchGroup.notify(queue: .main) {
            dump(self.currentWeather)
            self.updateWeatherInfo()
        }
    }
    
    private func getCurrentWeatherByCoordinates(latitude: Double, longitude: Double) {
        self.dispatchGroup.enter()
        webService.getCurrentWeather(latitude: latitude, longitude: longitude, cityName: nil) { result in
            switch result {
            case let .success(currentWeatherResponse):
                self.currentWeather = currentWeatherResponse
            case let .failure(error):
                showRetryAlert(title: "Error", message: error.localizedDescription, vc: self) {
                    self.getWeatherInfoByCoordinates(latitude: self.location.latitude, longitude: self.location.longitude)
                }
            }
            self.dispatchGroup.leave()
        }
    }
    
    private func getForecastWeatherByCoordinates(latitude: Double, longitude: Double) {
        self.dispatchGroup.enter()
        webService.getForecastWeather(latitude: latitude, longitude: longitude, cityName: nil) { result in
            switch result {
            case let .success(forecastWeatherResponse):
                if let response = forecastWeatherResponse {
                    let indexSet: IndexSet = self.createIndexSet(numberOfItems: response.list.count)
                    self.forecastWeatherItems = indexSet.map { response.list[$0] }
                }
            case let .failure(error):
                showRetryAlert(title: "Error", message: error.localizedDescription, vc: self) {
                    self.getWeatherInfoByCoordinates(latitude: self.location.latitude, longitude: self.location.longitude)
                }
            }
            self.dispatchGroup.leave()
        }
    }
    
    private func createIndexSet(numberOfItems: Int) -> IndexSet {
        let step = (numberOfItems) / 5
        var value = step
        var array = [Int]()
        
        for _ in 0..<5 {
            array.append(value-1)
            value = value + step
        }
        
        return IndexSet(array)
    }
    
}

extension MainWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !didFetchLocation {
            self.didFetchLocation = true
            self.location = locations[0].coordinate
            self.getWeatherInfoByCoordinates(latitude: location.latitude, longitude: location.longitude)
        }
    }
}


enum CurrentCondition: String {
    case cloudy = "Clouds"
    case rainy = "Rain"
    case clear = "Clear"
    
    var displayName: String {
        switch self {
        case .cloudy:
            return "Cloudy"
        case .rainy:
            return "Rainy"
        case .clear:
            return "Sunny"
        }
    }
    
    var imageName: String {
        switch self {
        case .cloudy:
            return "partlysunny"
        case .rainy:
            return "rain"
        case .clear:
            return "clear"
        }
    }
    
    var backgroundColorHexValue: Int {
        switch self {
        case .clear:
            return 0x47AB2F
        case .rainy:
            return 0x57575D
        case .cloudy:
            return 0x54717A
        }
    }
    
    var backgroundImageName: String {
        switch self {
        case .cloudy:
            return "forest_cloudy"
        case .rainy:
            return "forest_rainy"
        case .clear:
            return "forest_sunny"
        }
    }
}
