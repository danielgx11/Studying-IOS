//
//  TrafficLightViewController.swift
//  TrafficLights - MVP Study
//
//  Created by Daniel Gx on 18/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class TrafficLightViewController: UIViewController, TrafficLightViewDelegate {
    
    //MARK: -Variables
    
    private let trafficLightPresenter = TrafficLightPresenter(trafficLightService: TrafficLightService())
    
    //MARK: -Outlets
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var redLightOutlet: UIButton!
    @IBOutlet weak var yellowLightOutlet: UIButton!
    @IBOutlet weak var greenLightOutlet: UIButton!
    
    
    //MARK: -Action Buttons
    
    @IBAction func redLightButton(_ sender: Any) {
        trafficLightPresenter.trafficLightColorSelected(colorName: "Red")
    }
    
    @IBAction func yellowLightButton(_ sender: Any) {
        trafficLightPresenter.trafficLightColorSelected(colorName: "Yellow")
    }
    
    @IBAction func greenLightButton(_ sender: Any) {
        trafficLightPresenter.trafficLightColorSelected(colorName: "Green")
    }
    
    //MARK: -Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trafficLightPresenter.setViewDelegate(trafficLightViewDelegate: self)
        cornerRadius()
    }
    
    //MARK: -Funcs
    
    func displayTrafficLight(description: (String)) {
        descriptionLabel.text = description
    }
    
    func cornerRadius() {
        redLightOutlet.layer.cornerRadius = 25
        redLightOutlet.clipsToBounds = true
        
        yellowLightOutlet.layer.cornerRadius = 25
        yellowLightOutlet.clipsToBounds = true
        
        greenLightOutlet.layer.cornerRadius = 25
        greenLightOutlet.clipsToBounds = true
    }
    
}
