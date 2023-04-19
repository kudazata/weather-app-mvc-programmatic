//
//  Weather.swift
//  Weather App
//
//  Created by Kuda Zata on 29/11/2022.
//

import Foundation

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
