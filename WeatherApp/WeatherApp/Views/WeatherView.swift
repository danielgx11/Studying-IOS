//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Daniel Gx on 27/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import SwiftyJSON

class WeatherView: UIViewController, StoryboardInitialize {
    
    // MARK: - Properties
    
    var locationManager = CLLocationManager()
    
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var tempreatureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    
    
    var coordinator: WeatherViewFlow?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(locationManagement), with: nil)
    }
    
    // MARK: - Methods
    
    func parseJSONWithCodable(data: Data) {
        do {
            let weatherObject = try JSONDecoder().decode(WeatherModel.self, from: data)
            humidityLabel.text = "\(weatherObject.humidity)"
            cityNameLabel.text = weatherObject.name
            tempreatureLabel.text = "\(Int(weatherObject.tempreture))°C"
            windSpeedLabel.text = "\(weatherObject.windSpeed)"
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    func parseJSONWithSwifty(data: [String:Any]) { /// Parse JSON with SWIFTYJSON
        let jsonData = JSON(data)
        if let humidity = jsonData["main"]["humidity"].int {
            humidityLabel.text = "\(humidity)"
        }
        if let tempreature = jsonData["main"]["temp"].double {
            let celsius = tempreature-273.15
            tempreatureLabel.text = "\(Int(celsius))°C"
        }
        
        if let windSpeed = jsonData["wind"]["speed"].double {
            windSpeedLabel.text = "\(windSpeed)"
        }
        
        if let name = jsonData["name"].string {
            cityNameLabel.text = name
        }
    }
    
    func parseJSONManually(data: [String:Any]) { /// Parse JSON without SWIFTYJSON
        if let main = data["main"] as? [String:Any] {
            if let humidity = main["humidity"] as? Int {
                humidityLabel.text = "\(humidity)"
            }
            if let tempreature = main["temp"] as? Double {
                let celsius = tempreature-273.15
                tempreatureLabel.text = "\(Int(celsius))°C"
            }
        }
        if let wind = data["wind"] as? [String:Any] {
            if let windSpeed = wind["speed"] as? Double {
                windSpeedLabel.text = "\(windSpeed)"
            }
        }
        
        if let name = data["name"] as? String {
            cityNameLabel.text = name
        }
    }
    
    func getWeatherWithAlamofire(latitude: String, longitude: String) { /// Request with Alamofire
            guard let url = URL(string: APICLient.shared.getWeatherDataURL(latitude: latitude, longitude: longitude)) else {
                debugPrint("Could not from url")
                return
            }
            
            let headers: HTTPHeaders = [
                "Accept" : "application/json"
            ]
            
            let parameters: Parameters = [:]
            
            AF.request(url, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { [weak self] (response) in
                guard let strongSelf = self else { return }
                guard let data = response.data else { return }
                
                DispatchQueue.main.async {
                    strongSelf.parseJSONWithCodable(data: data)
                }
            }
            /*AF.request(url).responseJSON { (response) in
             if let jsonData = response.value as? [String:Any] {
             debugPrint(jsonData)
             }
             }*/
    }
    
    func getWeatherURLSession(latitude: String, longitude: String) { /// Get request without ALAMOFIRE
        
        let apiKey = APICLient.shared.apiKey
        
        if var urlComponents = URLComponents(string: APICLient.shared.baseURL) {
            urlComponents.query = "lat=\(latitude)&lon=\(longitude)&APPID=\(apiKey)"
            guard let url = urlComponents.url else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            let urlSessionconfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: urlSessionconfiguration)
            let datatask = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
                guard let data = data else { return }
                
                do {
                    guard let weatherData = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
                        debugPrint("There was an error converting data into JSON")
                        return
                    }
                    debugPrint(weatherData)
                } catch {
                    debugPrint("Error converting data into JSON")
                }
            }
            datatask.resume()
        }/*
         URLSession.shared.dataTask(with: weatherURL) { (data, response, error) in
             if let error = error {
                 debugPrint(error.localizedDescription)
             }
             guard let data = data else { return }
             
             do {
                 guard let weatherData = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
                     debugPrint("There was an error converting data into JSON")
                     return
                 }
                 debugPrint(weatherData)
             } catch {
                 debugPrint("Error converting data into JSON")
             }
             
         }.resume()
         */
    }
}

// MARK: - Location Manager Delegate

extension WeatherView: CLLocationManagerDelegate {
    @objc func locationManagement() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        getWeatherWithAlamofire(latitude: latitude, longitude: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied, .restricted:
            let ac = UIAlertController(title: "Location Acess Disabled", message: "WeatherApp needs your location to give a weather forecast. Open your settings to change authorization", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { (action) in
                guard let url = NSURL(string: UIApplication.openSettingsURLString) else { return }
                
                UIApplication.shared.open(url as URL, options: [:])
            }))
            
            present(ac, animated: true)
        default:
            fatalError()
        }
    }
}
