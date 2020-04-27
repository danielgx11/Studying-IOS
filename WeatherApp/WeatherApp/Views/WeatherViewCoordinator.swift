//
//  WeatherViewCoordinator.swift
//  WeatherApp
//
//  Created by Daniel Gx on 27/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol WeatherViewFlow: class {
    //
}

class WeatherViewCoordinator: Coordinator, WeatherViewFlow {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let weatherView = WeatherView.initFromStoryboard(name: "Main")
        weatherView.coordinator = self
        navigationController.pushViewController(weatherView, animated: true)
    }
    
    // MARK: - Flow Methods
    
    
}
