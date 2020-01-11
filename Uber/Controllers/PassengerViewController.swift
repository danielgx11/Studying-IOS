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
    
    //MARK: -Outlets
    @IBOutlet weak var map: MKMapView!
    @IBAction func toCallUber(_ sender: Any) {
        let database: DatabaseReference!
        database = Database.database().reference()
        let request = database.child("requests")

        let userDatas = [
            "email" : "danielgomes@ioasys.com.br",
            "nome" : "Daniel Passageiro",
            "latitude" : "1212121",
            "longitude" : "2323231"
        ]
        request.childByAutoId().setValue(userDatas)
    }
    
    
    //MARK: -Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationController()
        locationManagement()
    }
    
    //MARK: -Funcs
    
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
