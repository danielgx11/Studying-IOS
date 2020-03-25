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
    
    weak var coordinator: MainCoordinator?
    
    // MARK: - Outlets
    
    // MARK: - Actions Button
    
    @IBAction func buyButton(_ sender: Any) {
        self.coordinator?.buySubscription(to: product.selectedSegmentIndex)
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        coordinator?.createAccount()
    }
    
    @IBOutlet weak var product: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
