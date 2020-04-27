//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Daniel Gx on 24/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let weatherViewCoordinator = WeatherViewCoordinator(navigationController: navigationController)
        coordinate(to: weatherViewCoordinator)
    }
}
