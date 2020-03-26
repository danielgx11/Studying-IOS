//
//  CreateAccountViewController.swift
//  HowToUseCoordinatorPattern
//
//  Created by Daniel Gx on 24/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, Storyboarded {
    
    // MARK: - Variables
    
    weak var coordinator: profile?
    var confirmGender = String()
    var viewProfile: (() -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet var typedName: UITextField!
    @IBOutlet var typedEmail: UITextField!
    @IBOutlet var typedPhoneNumber: UITextField!
    @IBOutlet var selectedGender: UISwitch!
    
    // MARK: - Actions button
    
    @IBAction func signupButton(_ sender: UIButton) {
        guard self.fieldsValidation() else {return}
        viewProfile?()
    }
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Funcs
    
    func allertController(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Exit", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    func fieldsValidation() -> Bool {
        if typedName.hasText {
            if typedEmail.hasText {
                if typedPhoneNumber.hasText {
                    if selectedGender.isOn {
                        confirmGender = "Male"
                    } else {
                        confirmGender = "Female"
                    }
                    return true
                } else {
                    self.allertController(title: "Warning", message: "The phone number field isn't filled, fill and try again!")
                }
            } else {
                self.allertController(title: "Warning", message: "The email field isn't filled, fill and try again!")
            }
        } else {
            self.allertController(title: "Warning", message: "The name field isn't filled, fill and try again!")
        }
        return false
    }
}
