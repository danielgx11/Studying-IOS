//
//  ProfileCoordinator.swift
//  HowToUseCoordinatorPattern
//
//  Created by Daniel Gx on 25/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class ProfileCoordinator: Coordinator {
    
    // MARK: - Variables
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var name = "No account!"
    var email = "No account!"
    var phoneNumber = "No account!"
    var gender = "No account!"
    
    // MARK: - Funcs
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ProfileViewController.instantiate()
        vc.typedName = name
        vc.typedEmail = email
        vc.typedPhoneNumber = phoneNumber
        vc.typedGender = gender
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func didFinishProfile() {
        parentCoordinator?.childDidFinish(self)
    }
}
