//
//  Coordinator.swift
//  TableViewToMultipleView
//
//  Created by Daniel Gx on 15/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}
