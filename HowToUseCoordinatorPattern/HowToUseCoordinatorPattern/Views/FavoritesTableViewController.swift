//
//  FavoritesTableViewController.swift
//  HowToUseCoordinatorPattern
//
//  Created by Daniel Gx on 25/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController, Storyboarded {
    
    // MARK: - Variables
    
    weak var coordinator: FavoritesCoordinator?
    
    // MARK: - Life cycle
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.didFinishFavorites()
    }
}
