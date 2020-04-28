//
//  APIClient.swift
//  WeatherApp
//
//  Created by Daniel Gx on 27/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

/// To generate your API key go to  https://openweathermap.org

import Foundation

class APICLient {
    
    static let shared: APICLient = APICLient()
    
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    let apiKey = ""
    
    func getWeatherDataURL(latitude: String, longitude: String) -> String {
        return "\(baseURL)?lat=\(latitude)&lon=\(longitude)&APPID=\(apiKey)"
    }
}
