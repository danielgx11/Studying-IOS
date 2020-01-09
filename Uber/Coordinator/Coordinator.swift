//
//  Coordinator.swift
//  Uber
//
//  Created by ioasys on 09/01/20.
//  Copyright © 2020 danielGomes. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}
