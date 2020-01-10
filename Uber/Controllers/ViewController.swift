//
//  ViewController.swift
//  Uber
//
//  Created by ioasys on 08/01/20.
//  Copyright © 2020 danielGomes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    //MARK: -Variables
    
    weak var coordinator: MainCoordinator?

    //MARK: -Outlets
    
    @IBAction func loginButton(_ sender: Any) {
        self.coordinator?.loginViewController()
    }
    
    @IBAction func signupButton(_ sender: Any) {
        self.coordinator?.signupViewController()
    }
    
    //MARK: -Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationControllerCustoms()
    }
    
    //MARK: -Funcs
    
    func navigationControllerCustoms(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.title = "Uber"
    }
    
    //Create Allert
    func allertController (titulo: String, message: String){
        let alertController = UIAlertController(title: titulo, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: nil)
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
