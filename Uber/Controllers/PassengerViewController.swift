//
//  PassengerViewController.swift
//  Uber
//
//  Created by ioasys on 09/01/20.
//  Copyright © 2020 danielGomes. All rights reserved.
//

import UIKit

class PassengerViewController: UIViewController, Storyboarded {
    
    //MARK: -Variables
    
    weak var coordinator: MainCoordinator?
    
    //MARK: -Outlets
    
    //MARK: -Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationController()
    }
    
    //MARK: -Funcs
    
    func customizeNavigationController(){
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Uber"
        
    }

}
