//
//  MainTabBarController.swift
//  HowToUseCoordinatorPattern
//
//  Created by Daniel Gx on 25/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Variables
    
    let main = MainCoordinator(navigationController: UINavigationController())
    let favorites = FavoritesCoordinator(navigationController: UINavigationController())
    let profile = ProfileCoordinator(navigationController: UINavigationController())
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    // MARK: - Funcs
    
    func setTabBar() {
        main.start()
        favorites.start()
        profile.start()
        viewControllers = [main.navigationController, favorites.navigationController, profile.navigationController]
    }
}
