//
//  ProfileViewController.swift
//  HowToUseCoordinatorPattern
//
//  Created by Daniel Gx on 25/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Storyboarded {
    
    // MARK: - Variables
    
    weak var coordinator: ProfileCoordinator?
    var typedName = "No account!"
    var typedEmail = "No account!"
    var typedPhoneNumber = "No account!"
    var typedGender = "No account!"
    
    // MARK: - Outlets
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    
    // MARK: - Actions button
    
    @IBAction func openHwsButton(_ sender: UIButton) {
        /// Open hacking with swift website
        UIApplication.shared.open(URL(string: "https://www.hackingwithswift.com/")!)
        
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProfileFeatures()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.didFinishProfile()
    }
    
    // MARK: - Funcs
    
    func setProfileFeatures() {
        nameLabel.text = typedName
        emailLabel.text = typedEmail
        phoneNumberLabel.text = typedPhoneNumber
        genderLabel.text = typedGender
    }
}
