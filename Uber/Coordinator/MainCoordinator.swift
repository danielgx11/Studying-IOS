//
//  MainCoordinator.swift
//  Uber
//
//  Created by ioasys on 09/01/20.
//  Copyright © 2020 danielGomes. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MapKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init (navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func loginViewController(){
        let loginViewController = LoginViewController.instantiate()
        loginViewController.coordinator = self
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func signupViewController(){
        let signupViewController = SignupViewController.instantiate()
        signupViewController.coordinator = self
        navigationController.pushViewController(signupViewController, animated: true)
    }
    
    func passengerViewController(){
        let passengerViewController = PassengerViewController.instantiate()
        passengerViewController.coordinator = self
        navigationController.pushViewController(passengerViewController, animated: true)
    }
  
    func driverTableViewController(){
        let driverTableViewController = DriverTableViewController.instantiate()
        driverTableViewController.coordinator = self
        navigationController.pushViewController(driverTableViewController, animated: true)
    }
    
    func acceptRequest(to driverLocalization: Any, passengerLocalization: Any, passengerName: String, passengerEmail: String){
        let acceptRequestViewController = AcceptRequestViewController.instantiate()
        acceptRequestViewController.driverLocation = driverLocalization as! CLLocationCoordinate2D
        acceptRequestViewController.passengerLocation = passengerLocalization as! CLLocationCoordinate2D
        acceptRequestViewController.passengerName = passengerName
        acceptRequestViewController.passengerEmail = passengerEmail
        acceptRequestViewController.coordinaator = self
        navigationController.pushViewController(acceptRequestViewController, animated: true)
    }
}
