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
    var driverLocation = CLLocationCoordinate2D()
    var CallUber = false
    var uberOnTheWay = false
    
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
        checkExistingRequest()
        
        //Driver accept ride
        listernerAcceptDriver()
    }
    
    //MARK: -Funcs
    
    func showDriverAndPassenger(){
        
        self.uberOnTheWay = true
        
        //Calculate distance between driver and passenger
        let driverLocalization = CLLocation(latitude: self.driverLocation.latitude, longitude: self.driverLocation.longitude)
        
        let passengerLocalization = CLLocation(latitude: self.userLocation.latitude, longitude: self.userLocation.longitude)
        
        let distance = driverLocalization.distance(from: passengerLocalization)
        let kmDistance = distance/1000
        let endDistance = round(kmDistance)
        
        self.toCallUberOutlet.backgroundColor = UIColor(red: 0.831, green: 0.237, blue: 0.146, alpha: 1)
        self.toCallUberOutlet.setTitle("Motorista a \(endDistance) KM de distância", for: .normal)
        
        
        //Display driver and passenger in map
        map.removeAnnotations(map.annotations)
        
        let region = MKCoordinateRegion(center: self.userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
        map.setRegion(region, animated: true)
        
        //Driver annotation
        let driverAnotation = MKPointAnnotation()
        driverAnotation.coordinate = self.driverLocation
        driverAnotation.title = "Motorista"
        map.addAnnotation(driverAnotation)
        
        //Passenger annotation
        let passengerAnotation = MKPointAnnotation()
        passengerAnotation.coordinate = self.userLocation
        passengerAnotation.title = "Passageiro"
        map.addAnnotation(passengerAnotation)
    }
    
    func listernerAcceptDriver(){
        let database = Database.database().reference()
        let autentication = Auth.auth()
        
        if let userEmail = autentication.currentUser?.email {
            let requests = database.child("requisicoes")
            let checkRequest = requests.queryOrdered(byChild: "email").queryEqual(toValue: userEmail)
            
            checkRequest.observe(.childChanged) { (snapshot) in
                
                if let data = snapshot.value as? [String: Any] {
                    if let driverLatitude = data["motoristaLatitude"] {
                        if let driverLongitude = data["motoristaLongitude"] {
                            self.driverLocation = CLLocationCoordinate2D(latitude: driverLatitude as! CLLocationDegrees, longitude: driverLongitude as! CLLocationDegrees)
                            self.showDriverAndPassenger()
                        }
                    }
                }
            }
        }
    }
    
    func checkExistingRequest(){
        let database = Database.database().reference()
        let autentication = Auth.auth()
        
        if let userEmail = autentication.currentUser?.email {
            let requests = database.child("requisicoes")
            let checkRequest = requests.queryOrdered(byChild: "email").queryEqual(toValue: userEmail)
            
            checkRequest.observe(.childAdded) { (snapshot) in
                
                if snapshot.value != nil {
                    self.alternateCancelButton()
                }
            }
        }
    }
    
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
