//
//  LoginViewController.swift
//  Uber
//
//  Created by ioasys on 09/01/20.
//  Copyright © 2020 danielGomes. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, Storyboarded {

    //MARK: -Outlets
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBAction func loginButton(_ sender: Any) {
        
        let returnConfirm = self.validateFields()
        if returnConfirm == "" {
            //User autentication
            let autentication = Auth.auth()
            if let recoveredEmail = self.emailText.text{
                if let recoveredPassword = self.passwordText.text {
                    autentication.signIn(withEmail: recoveredEmail, password: recoveredPassword) { (usuario, erro) in
                            if erro == nil {
                                if usuario != nil {
                                    self.coordinator?.passengerViewController()
                                }
                            }
                            else {
                                self.allertController(titulo: "Observação", message: "Erro \(String(describing: erro)) ao criar conta!")
                        }
                    }
                }
            }
        }
        else {
            allertController(titulo: "Observação", message: "O campo \(returnConfirm) não foi preenchido")
        }
    }
    
    
    //MARK: -Variables
    
    weak var coordinator: MainCoordinator?
    
    //MARK: -Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: -Funcs
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func validateFields() -> String {
        if (self.emailText.text?.isEmpty)! {
            return "E-mail!"
        }
        else if (self.passwordText.text?.isEmpty)! {
            return "senha"
        }
        return ""
    }
    
    //Create Allert
    func allertController (titulo: String, message: String){
        let alertController = UIAlertController(title: titulo, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: nil)
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }

}
