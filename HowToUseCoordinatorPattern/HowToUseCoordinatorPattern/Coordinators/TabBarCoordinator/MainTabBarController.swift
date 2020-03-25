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
    let buy = BuyCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    // MARK: - Funcs
    
    func setTabBar() {
        main.start()
        buy.start()
        viewControllers = [main.navigationController, buy.navigationController]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
