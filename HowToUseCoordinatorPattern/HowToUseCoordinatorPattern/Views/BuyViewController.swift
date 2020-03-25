//
//  BuyViewController.swift
//  HowToUseCoordinatorPattern
//
//  Created by Daniel Gx on 24/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController, Storyboarded {
    
    // MARK: - Variables
    
    weak var coordinator: BuyCoordinator?
    var selectedProduct = 0
    
    // MARK: - Outlets
    
    @IBOutlet var productSelectedLabel: UILabel!
        
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectedProduct(id: selectedProduct)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        coordinator?.didFinishBuying()
    }
    
    // MARK: - Funcs
    
    func setSelectedProduct(id: Int) {
        if id == 0 {
            productSelectedLabel.text = "First product!"
        } else {
            productSelectedLabel.text = "Second product!"
        }
    }

}
