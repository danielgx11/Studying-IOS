//
//  TBVC.swift
//  TableViewToMultipleView
//
//  Created by Daniel Gx on 15/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController, Storyboarded {
    
    //MARK: -Outlets
    
    //MARK: -Variables
    
    weak var coordinator: MainCoordinator?
    
    var names = [String]()
    var identities = [String]()
    
    //MARK: -Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        names = ["firstCell","secondCell","thirdCell","fourthCell"]
        identities = ["FirstViewController", "SecondViewController", "ThirdViewController", "FourthViewController"]
    }
    
    //MARK: -Funcs
    
    //MARK: -TableViewFuncs
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell")
        
        cell?.textLabel?.text = names[indexPath.row]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let viewControllerName = identities[indexPath.row]
        
        debugPrint(viewControllerName)
        
        if viewControllerName == "FirstViewController" {
            self.coordinator?.firstViewController()
        }
        else if viewControllerName == "SecondViewController" {
            self.coordinator?.secondViewController()
        }
        else if viewControllerName == "ThirdViewController" {
            self.coordinator?.thirdViewController()
        }
        else if viewControllerName == "FourthViewController" {
            self.coordinator?.fourthViewController()
        }
    }
}
