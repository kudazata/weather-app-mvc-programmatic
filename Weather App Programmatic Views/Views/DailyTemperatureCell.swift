//
//  DailyTemperatureCell.swift
//  Weather App Programmatic Views
//
//  Created by Kuda Zata on 19/4/2023.
//

import UIKit

class DailyTemperatureCell: UITableViewCell {
    
    var temperatureLabel = UILabel()
    var dayLabel = UILabel()
    var conditionImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        temperatureLabel = UILabel()
        temperatureLabel.textColor = .white
        dayLabel = UILabel()
        dayLabel.textColor = .white
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(temperatureLabel)
        self.addSubview(dayLabel)
        self.addSubview(conditionImageView)
        
        let temperatureLabelConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: temperatureLabel, attribute: .trailing, multiplier: 1, constant: 20)
        let temperatureLabelCentreYConstraint = NSLayoutConstraint(item: temperatureLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let dayLabelConstraint = NSLayoutConstraint(item: dayLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10)
        let dayLabelCentreYConstraint = NSLayoutConstraint(item: dayLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        let conditionImageCentreYConstraint = NSLayoutConstraint(item: conditionImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let conditionImageCentreXConstraint = NSLayoutConstraint(item: conditionImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        
        self.addConstraints([temperatureLabelConstraint, temperatureLabelCentreYConstraint, dayLabelConstraint, dayLabelCentreYConstraint, conditionImageCentreYConstraint, conditionImageCentreXConstraint])
        
        let conditionImageHeightConstraint = NSLayoutConstraint(item: conditionImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        let conditionImageWidthConstraint = NSLayoutConstraint(item: conditionImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        
        conditionImageView.addConstraints([conditionImageHeightConstraint, conditionImageWidthConstraint])
        
        self.backgroundColor = .clear
    }
    
    func configureCell(forecastWeather: ForecastWeatherItem) {
        temperatureLabel.text = forecastWeather.main.temp.toStringWithZeroDecimalPlaces() + "°"
        dayLabel.text = forecastWeather.dtTxt.dayOfWeek() ?? "--"
        let condition = CurrentCondition(rawValue: forecastWeather.weather[0].main)
        conditionImageView.image = UIImage(named: condition?.imageName ?? "partlysunny")
    }

}
