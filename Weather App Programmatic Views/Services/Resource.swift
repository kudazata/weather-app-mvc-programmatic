//
//  Resource.swift
//  Weather App
//
//  Created by Kuda Zata on 30/11/2022.
//

import Foundation

/// A resource object to be created when making network calls
struct Resource<T> {
    let urlString: String
    let parse: (Data) -> T?
}
