//
//  ProfileViewController.swift
//  HowToUseCoordinatorPattern
//
//  Created by Daniel Gx on 25/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Storyboarded {
    
    // MARK: - Variables
    
    weak var coordinator: ProfileCoordinator?
    
    // MARK: - Life cycle
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.didFinishProfile()
    }
}
