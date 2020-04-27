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
    
    func getWeathrURLSession(latitude: String, longitude: String) {
        guard let weatherURL = URL(string: APICLient.shared.getWeatherDataURL(latitude: latitude, longitude: longitude)) else { return }
        
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
        
        getWeathrURLSession(latitude: latitude, longitude: longitude)
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
