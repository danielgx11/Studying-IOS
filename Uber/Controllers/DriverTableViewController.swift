//
//  DriverTableViewController.swift
//  Uber
//
//  Created by ioasys on 12/01/20.
//  Copyright © 2020 danielGomes. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseDatabase

class DriverTableViewController: UITableViewController, CLLocationManagerDelegate, Storyboarded {

    //MARK: -Variables
    weak var coordinator: MainCoordinator?
    let viewController = ViewController()
    var logoutButton: UIBarButtonItem?
    var resquestList: [DataSnapshot] = []
    var locationManager = CLLocationManager()
    var driverLocation = CLLocationCoordinate2D()
    
    
    //MARK: -Outlets
    
    
    //MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeNavigationController()
        
        //Driver location
        self.locationManagement()
        
        //Configure database
        let database = Database.database().reference()
        let requests = database.child("requisicoes")
        
        //Recovered requests
        requests.observe(.childAdded) { (snapshot) in
            
            self.resquestList.append(snapshot)
            self.tableView.reloadData()
            
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.resquestList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        let snapshot = self.resquestList[indexPath.row]
        if let data = snapshot.value as? [String: Any] {
            
            if let passengerLatitude = data["latitude"] as? Double {
                if let passengerLongitude = data["longitude"] as? Double {
                    
                    let driverLocation = CLLocation(latitude: self.driverLocation.latitude, longitude: self.driverLocation.longitude)
                    let passengerLocation = CLLocation(latitude: passengerLatitude, longitude: passengerLongitude)
                    
                    let distanceInMeters = driverLocation.distance(from: passengerLocation)
                    
                    let distanceInKm = distanceInMeters/1000
                    let endDistance = round(distanceInKm)
                    
                    cell.textLabel?.text = data["nome"] as? String
                    cell.detailTextLabel?.text = "\(endDistance) KM de distância"
                }
            }
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Passing data by coordinator pattern
        let snapshot = self.resquestList[indexPath.row]
        if let data = snapshot.value as? [String: Any] {
            
            if let passengerLatitude = data["latitude"] as? Double {
                if let passengerLongitude = data["longitude"] as? Double {
                    
                    let driverLocation = CLLocationCoordinate2D(latitude: self.driverLocation.latitude, longitude: self.driverLocation.longitude)
                    let passengerLocation = CLLocationCoordinate2D(latitude: passengerLatitude, longitude: passengerLongitude)
                    
                    let passengerName = data["nome"] as? String
                    let passengerEmail = data["email"] as? String
                    
                    self.coordinator?.acceptRequest(to: driverLocation, passengerLocalization: passengerLocation, passengerName: passengerName!, passengerEmail: passengerEmail!)
                }
            }
            
        }
    }
    
    //MARK: -Funcs

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = manager.location?.coordinate {
            self.driverLocation = coordinate
        }
    }
    
    func locationManagement(){
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

    }
    
    func customizeNavigationController(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Requisições"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sair", style: .plain, target: self, action: #selector(DriverTableViewController.addTapped(_:)) )
    }
    
    @objc func addTapped(_ sender:UIBarButtonItem!){
        //Logout user
        self.viewController.logoutUser()
        self.coordinator?.start()
    }
}
