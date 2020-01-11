//
//  ViewController.swift
//  Uber
//
//  Created by ioasys on 08/01/20.
//  Copyright © 2020 danielGomes. All rights reserved.
//

import UIKit
import FirebaseAuth

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
        
        let autentication = Auth.auth()
        //logoutUser()
        
        autentication.addStateDidChangeListener { (autentication, user) in
            if let loginUser = user {
                self.coordinator?.passengerViewController()
            }
            else {
                
            }
        }
        

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
    
    //Logout user
    
    func logoutUser(){
        let autentication = Auth.auth()
        do {
            try autentication.signOut()
        } catch let error {
            allertController(titulo: "Observação", message: "O usuário não pode ser deslogado devido ao erro \(error)")
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
