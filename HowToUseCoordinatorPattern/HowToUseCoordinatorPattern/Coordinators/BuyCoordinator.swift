//
//  BuyCoordinator.swift
//  HowToUseCoordinatorPattern
//
//  Created by Daniel Gx on 25/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class BuyCoordinator: Coordinator {

    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var selectedProduct = 0
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = BuyViewController.instantiate()
        vc.coordinator = self
        vc.selectedProduct = selectedProduct
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        navigationController.pushViewController(vc, animated: true)
    }
    func didFinishBuying() {
        parentCoordinator?.childDidFinish(self)
    }
}
