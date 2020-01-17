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
    
    
    //MARK: -Variables
    
    weak var coordinaator: MainCoordinator?
    var selectedRequest: [DataSnapshot] = []
    let driver = DriverTableViewController()
    var passengerName = ""
    var passengerEmail = ""
    var passengerLocation = CLLocationCoordinate2D()
    var driverLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initial map location
        let region = MKCoordinateRegion(center: self.passengerLocation, latitudinalMeters: 200, longitudinalMeters: 200)
        map.setRegion(region, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
