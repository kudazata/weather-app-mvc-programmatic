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
        self.addSubview(temperatureLabel)
        self.addSubview(dayLabel)
        let temperatureLabelConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: temperatureLabel, attribute: .trailing, multiplier: 1, constant: 20)
        let temperatureLabelCentreYConstraint = NSLayoutConstraint(item: temperatureLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let dayLabelConstraint = NSLayoutConstraint(item: dayLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10)
        let dayLabelCentreYConstraint = NSLayoutConstraint(item: dayLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(temperatureLabelConstraint)
        self.addConstraint(temperatureLabelCentreYConstraint)
        self.addConstraint(dayLabelConstraint)
        self.addConstraint(dayLabelCentreYConstraint)
        self.backgroundColor = .clear
    }
    
    func configureCell(forecastWeather: ForecastWeatherItem) {
        temperatureLabel.text = forecastWeather.main.temp.toStringWithZeroDecimalPlaces() + "°"
        dayLabel.text = forecastWeather.dtTxt.dayOfWeek() ?? "--"
    }

}
