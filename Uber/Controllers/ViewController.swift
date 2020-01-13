//
//  ViewController.swift
//  Uber
//
//  Created by ioasys on 08/01/20.
//  Copyright © 2020 danielGomes. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

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
        
        //Navigation between views
        autentication.addStateDidChangeListener { (autentication, user) in
            if let loginUser = user {
                
                //Verify user kind
                let database = Database.database().reference()
                let users = database.child("usuarios").child(loginUser.uid)
                
                users.observeSingleEvent(of: .value) { (snapshot) in
                    
                    let data = snapshot.value as? NSDictionary
                    if (data != nil){
                        let userKind = data!["tipo"] as! String
                        if userKind == "Passageiro"{
                            self.coordinator?.passengerViewController()
                        }
                        else if userKind == "Motorista" {
                            self.coordinator?.driverTableViewController()
                        }
                    }
                }
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
