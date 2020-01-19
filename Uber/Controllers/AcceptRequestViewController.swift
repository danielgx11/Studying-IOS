//
//  AcceptRequestViewController.swift
//  Uber
//
//  Created by ioasys on 16/01/20.
//  Copyright © 2020 danielGomes. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseDatabase

class AcceptRequestViewController: UIViewController, Storyboarded {
    
    //MARK: -Outlets
    @IBOutlet weak var map: MKMapView!
    @IBAction func toAcceptButton(_ sender: Any) {
        //request update
        let database = Database.database().reference()
        let requests = database.child("Requisicoes")
        
        requests.queryOrdered(byChild: "email").queryEqual(toValue: self.passengerEmail).observeSingleEvent(of: .childAdded) { (snapshot) in
            
            //Update data
            let driverData = [
                "motoristaLatitude" : self.driverLocation.latitude,
                "motoristaLongitude" : self.driverLocation.longitude
            ]
            
            snapshot.ref.updateChildValues(driverData)
            
        }
        
        //Show route to the passenger
        
        let passengerCLL = CLLocation(latitude: passengerLocation.latitude, longitude: passengerLocation.longitude)
        CLGeocoder().reverseGeocodeLocation(passengerCLL) { (place, error) in
            
            if error == nil {
                
                if let locationData = place?.first {
                    let placeMark = MKPlacemark(placemark: locationData)
                    let itemMap = MKMapItem(placemark: placeMark)
                    itemMap.name = self.passengerName
                    
                    let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                    itemMap.openInMaps(launchOptions: options)
                }
            }
        }
    }
    
    
    //MARK: -Variables
    
    weak var coordinaator: MainCoordinator?
    let driver = DriverTableViewController()
    var passengerName = ""
    var passengerEmail = ""
    var passengerLocation = CLLocationCoordinate2D()
    var driverLocation = CLLocationCoordinate2D()
    
    //MARK: -Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initial map location
        let region = MKCoordinateRegion(center: self.passengerLocation, latitudinalMeters: 200, longitudinalMeters: 200)
        map.setRegion(region, animated: true)
        self.locationAnnotation(to: passengerName)
    
    }
    
    //MARK: -Funcs
    
    func locationAnnotation(to passengerName: String){
        let anotUser = MKPointAnnotation()
        anotUser.coordinate = passengerLocation
        anotUser.title = passengerName
        map.addAnnotation(anotUser)
    }
    
    func updateRequest(){
        let database = Database.database().reference()
        let requests = database.child("Requisicoes")
        
        requests.queryOrdered(byChild: "email").queryEqual(toValue: self.passengerEmail).observeSingleEvent(of: .childAdded) { (snapshot) in
            
            //Update data
            let driverData = [
                "motoristaLatitude" : self.driverLocation.latitude,
                "motoristaLongitude" : self.driverLocation.longitude
            ]
            
            snapshot.ref.updateChildValues(driverData)
            
        }
    }
}
