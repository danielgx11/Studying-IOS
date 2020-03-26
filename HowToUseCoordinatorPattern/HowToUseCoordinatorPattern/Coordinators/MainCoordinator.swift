//
//  MainCoordinator.swift
//  HowToUseCoordinatorPattern
//
//  Created by Daniel Gx on 24/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator, Buying, AccountCreating, profile {
    
    // MARK: - Variables
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    // MARK: - Funcs
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainViewController.instantiate()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        vc.buyAction = { [weak self] in
            self?.buySubscription(to: vc.product.selectedSegmentIndex)
        }
        
        vc.createAccountAction = {[weak self] in
            self?.createAccount()
        }
        navigationController.pushViewController(vc, animated: false)
    }
    
    func buySubscription(to productType: Int) {
        let child = BuyCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.selectedProduct = productType
        child.start()
    }
    
    func createAccount() {
        let vc = CreateAccountViewController.instantiate()
        vc.viewProfile = { [weak self] in
            self?.profileView(name: vc.typedName.text!, email: vc.typedEmail.text!, phoneNumber: vc.typedPhoneNumber.text!, gender: vc.confirmGender)
        }
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func favoritesView() {
        let child = FavoritesCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }
    
    func profileView(name: String, email: String, phoneNumber: String, gender: String) {
        let child = ProfileCoordinator(navigationController: navigationController)
        child.name = name
        child.email = email
        child.phoneNumber = phoneNumber
        child.gender = gender
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }
    
    // MARK: - Remove ChildCoordinators
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

}

