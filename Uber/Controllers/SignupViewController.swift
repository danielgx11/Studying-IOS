//
//  SignupViewController.swift
//  Uber
//
//  Created by ioasys on 09/01/20.
//  Copyright © 2020 danielGomes. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignupViewController: UIViewController, Storyboarded {

    //MARK: -Variables
    
    weak var coordinator: MainCoordinator?
    let viewController = ViewController()
    
    //MARK: -Outlets
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var completeNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var userKindSwitch: UISwitch!
    @IBAction func signupButton(_ sender: Any) {
        
        let returnConfirm = self.validateFields()
        if returnConfirm == "" {
            //Save data on Firebase
            if passwordText.text == confirmPasswordText.text {
                let autentication = Auth.auth()
                if let recoveredEmail = self.emailText.text {
                    if let recoveredName = self.completeNameText.text {
                        if let recoveredPassword = self.passwordText.text {
                            autentication.createUser(withEmail: recoveredEmail, password: recoveredPassword) { (user, erro) in
                                    if erro == nil {
                                        self.allertController(titulo: "Observação", message: "Sucesso ao criar conta!")
                                        //Validation login
                                        if user != nil {
                                            
                                            //Configure database
                                            let database = Database.database().reference()
                                            let users = database.child("usuarios")
                                            
                                            //User kind
                                            var kind = ""
                                            if self.userKindSwitch.isOn {//Passenger
                                                kind = "Passageiro"
                                            }
                                            else {//Driver
                                                kind = "Motorista"
                                            }
                                            
                                            //Save user data in FirebaseDatabase
                                            let userData = [
                                                "email" : recoveredEmail ,
                                                "nome" : recoveredName ,
                                                "tipo" : kind
                                            ]
                                            
                                            //Save data
                                            users.child(String((user?.user.uid)!)).setValue(userData)
                                        }
                                        else {
                                            self.allertController(titulo: "Observação", message: "Erro ao autenticar usuário!")
                                            }
                                        }
                                        else {
                                            self.allertController(titulo: "Observação", message: "Erro \(String(describing: erro)) ao criar conta!")
                                }
                            }
                        }
                    }
                }
            }
            else {
                allertController(titulo: "Observação", message: "As senhas digitadas não coincidem!")
            }
            
        }
        else {
            allertController(titulo: "Observação", message: "O campo \(returnConfirm) não foi preenchido")
        }
    }
    
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
        else if (self.completeNameText.text?.isEmpty)! {
            return "Nome completo"
        }
        else if (self.passwordText.text?.isEmpty)! {
            return "senha"
        }
        else if (self.confirmPasswordText.text?.isEmpty)! {
            return "Validação de senha"
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
