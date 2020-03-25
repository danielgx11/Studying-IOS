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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        debugPrint(selectedProduct)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        coordinator?.didFinishBuying()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
