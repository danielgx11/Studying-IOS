//
//  PassengerViewController.swift
//  Uber
//
//  Created by ioasys on 09/01/20.
//  Copyright © 2020 danielGomes. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import MapKit

class PassengerViewController: UIViewController, Storyboarded, CLLocationManagerDelegate {
    
    //MARK: -Variables
    
    weak var coordinator: MainCoordinator?
    var logoutButton: UIBarButtonItem?
    let viewController = ViewController()
    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    var CallUber = false
    
    //MARK: -Outlets
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var toCallUberOutlet: UIButton!
    
    
    @IBAction func toCallUber(_ sender: Any) {
        
        let database = Database.database().reference()
        let autentication = Auth.auth()
        let request = database.child("requisicoes")
        
        if let userEmail = autentication.currentUser?.email {
            
            if self.CallUber {//uber to call
                self.alternateToCallUber()
                
                //Remove request
                let request = database.child("requisicoes")
                request.queryOrdered(byChild: "email").queryEqual(toValue: userEmail).observeSingleEvent(of: .childAdded) { (snapshot) in
                    snapshot.ref.removeValue()
                    
                }
            }
            else {//don't to call uber
                
                if let userId = autentication.currentUser?.uid {
                    
                    //Recovered passenger name
                    let database = Database.database().reference()
                    let users = database.child("usuarios").child(userId)
                    
                    users.observeSingleEvent(of: .value) { (snapshot) in
                        
                        let data = snapshot.value as? NSDictionary
                        let userName = data!["nome"] as? String
                        
                        self.alternateCancelButton()
                        
                        //Save request data
                        let userDatas = [
                            "email" : userEmail,
                            "nome" : userName,
                            "latitude" : self.userLocation.latitude,
                            "longitude" : self.userLocation.longitude
                            ] as [String : Any]
                        request.childByAutoId().setValue(userDatas)
                        
                    }
                }
            }
        }
    }
    
    
    
    //MARK: -Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationController()
        locationManagement()
        
        //Check existing request
        let database = Database.database().reference()
        let autentication = Auth.auth()
        
        if let userEmail = autentication.currentUser?.email {
            let requests = database.child("Requisicoes")
            let checkRequest = requests.queryOrdered(byChild: "email").queryEqual(toValue: userEmail)
            
            checkRequest.observe(.childAdded) { (snapshot) in
                
                if snapshot.value != nil {
                    self.alternateCancelButton()
                }
            }
        }
    }
    
    //MARK: -Funcs
    
    func alternateCancelButton (){
        self.toCallUberOutlet.setTitle("Cancelar Uber", for: .normal)
        self.toCallUberOutlet.backgroundColor = UIColor(red: 0.831, green: 0.237, blue: 0.146, alpha: 1)
        self.CallUber = true
    }
    
    func alternateToCallUber(){
        self.toCallUberOutlet.setTitle("Chamar Uber", for: .normal)
        self.toCallUberOutlet.backgroundColor = UIColor(red: 17/255, green: 147/255, blue: 154/255, alpha: 1.0)
        self.CallUber = false
    }
    
    func customizeNavigationController(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Uber"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sair", style: .plain, target: self, action: #selector(PassengerViewController.addTapped(_:)) )
    }
    
    func locationManagement(){
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinates = manager.location?.coordinate {
            //Current user location
            self.userLocation = coordinates
            
            let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 200, longitudinalMeters: 200)
            map.setRegion(region, animated: true)
            
            //Remove old annotations
            map.removeAnnotations(map.annotations)
            
            //Create annotation user location
            let userAnnotation = MKPointAnnotation()
            userAnnotation.coordinate = coordinates
            userAnnotation.title = "My location"
            map.addAnnotation(userAnnotation)
        }

    }

    @objc func addTapped(_ sender:UIBarButtonItem!){
        //Logout user
        self.viewController.logoutUser()
        self.coordinator?.start()
    }
}
