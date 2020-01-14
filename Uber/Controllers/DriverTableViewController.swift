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
    let passengerViewController = PassengerViewController()
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
        passengerViewController.locationManagement()
        
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
                    
                    cell.textLabel?.text = data["nome"] as? String
                    cell.detailTextLabel?.text = "\(distanceInKm) KM de distância"
                }
            }
            
        }

        return cell
    }
    
    //MARK: -Funcs

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = manager.location?.coordinate {
            self.driverLocation = coordinate
        }
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
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
