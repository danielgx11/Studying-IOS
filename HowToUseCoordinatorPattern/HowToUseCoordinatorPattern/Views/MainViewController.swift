//
//  MainViewController.swift
//  HowToUseCoordinatorPattern
//
//  Created by Daniel Gx on 24/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, Storyboarded {
    
    // MARK: - Variables
    
    /// Using protocols and closures with coordinator pattern
    
    var buyAction: (() -> Void)?
    var createAccountAction: (() -> Void)?
        
    // MARK: - Actions Button
    
    @IBAction func buyButton(_ sender: Any) {
        buyAction?()
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        createAccountAction?()
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var product: UISegmentedControl!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
