//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Daniel Gx on 28/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import Foundation

class WeatherModel: NSObject, Codable {
    
    // MARK: - Properties
    
    var name: String = ""
    var tempreture: Double = 0.0
    var humidity: Int = 0
    var windSpeed: Double = 0.0
    
    enum CodingKeys: String, CodingKey {
        case name
        case main
        case wind
        case humidity
        case temp
        case speed
    }
    
    // MARK: - Methods
    
    override init() {
        
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let main = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .main)
        let wind = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .wind)
        
        name = try container.decode(String.self, forKey: .name)
        tempreture = try main.decode(Double.self, forKey: .temp)
        humidity = try main.decode(Int.self, forKey: .humidity)
        windSpeed = try wind.decode(Double.self, forKey: .speed)
    }
}
