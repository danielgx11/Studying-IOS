//
//  ViewController.swift
//  PokemonGOAula
//
//  Created by Daniel Gx.
//  Copyright © Daniel Gx. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: -Variables
    
    lazy var presenter = ViewControllerPresenter(with: self)
    var managerLocation = CLLocationManager()
    var pokemons: [Pokemon] = []
    var coreDataPokemon: CoreDataPokemon!
    
    // MARK: -Outlets
    
    @IBOutlet weak var mapView: MKMapView!

    // MARK: -Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recoverPokemons()
    }
    
    @IBAction func centralizar(_ sender: AnyObject) {
        centerLocation()
    }
    
    // MARK: -Funcs
    
    func alertController(title: String, message: String, settingsIsOn: Bool = false) {
        let allertController = UIAlertController(title: title,
                                                 message: message,
                                                 preferredStyle: .alert )
        if settingsIsOn {
            let settingsAction = UIAlertAction(title: "Abrir configurações", style: .default , handler: { (alertaConfiguracoes) in
                    if let settings = NSURL(string: UIApplicationOpenSettingsURLString ) {
                    UIApplication.shared.open( settings as URL )
                }
            })
            allertController.addAction( settingsAction )
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default , handler: nil )
        allertController.addAction(cancelAction)
        present(allertController, animated: true, completion: nil )
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: -Extensions

extension ViewController: PresenterView {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status != .authorizedWhenInUse && status != .notDetermined {
            self.alertController(title: "Permissão de localização", message: "Necessário permissão para acesso à sua localização!! por favor habilite.", settingsIsOn: true)
        }
    }
    
    func centerLocation(){
        if let coordinates = managerLocation.location?.coordinate {
            let regiao = MKCoordinateRegionMakeWithDistance( coordinates, 200, 200)
            mapView.setRegion(regiao, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        let annotation = view.annotation
        let coordinates = annotation?.coordinate
        mapView.deselectAnnotation(annotation, animated: true)
        
        if annotation is MKUserLocation {
            return
        }
        
        let region = MKCoordinateRegionMakeWithDistance( coordinates!, 200, 200)
        mapView.setRegion(region, animated: true)
        
        let pokemon = (view.annotation as! PokemonAnotacao).pokemon

            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
                if let coord = self.managerLocation.location?.coordinate {
                    if MKMapRectContainsPoint(self.mapView.visibleMapRect, MKMapPointForCoordinate(coord)) {
                        print("Você pode capturar o Pokemon!!")
                        
                        let context = self.coreDataPokemon.getContext()
                        pokemon.capturado = true
                        
                        do{
                            try context.save()
                            self.mapView.removeAnnotation(view.annotation!)
                            self.alertController(title: "Parabéns!!", message: "Você capturou o \(pokemon.nome!) ")
                        }catch{
                            self.alertController(title: "Ops!", message: "Por algum motivo você não conseguiu capturar o pokemon, tente novamente!")
                        }
                        
                    }else{
                        self.alertController(title: "Você não pode Capturar", message: "Você precisa se aproximar mais para capturar o \(pokemon.nome!) ")
                    }
                }
            })
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let isAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKUserLocation {
            isAnnotation.image = #imageLiteral(resourceName: "player")
        }else{
            let pokemon = (annotation as! PokemonAnotacao).pokemon
            isAnnotation.image = UIImage(named: pokemon.nomeImagem! )
        }
        
        var frame = isAnnotation.frame
        frame.size.height = 40
        frame.size.width  = 40
        isAnnotation.frame = frame
        
        return isAnnotation
    }
}

extension ViewController {
    func recoverPokemons() {
        self.navigationController?.isToolbarHidden = true
        self.coreDataPokemon = CoreDataPokemon()
        pokemons = coreDataPokemon.recoverAllPokemons()
        
        managerLocation.delegate = self
        mapView.delegate = self
        managerLocation.requestWhenInUseAuthorization()
        managerLocation.startUpdatingLocation()
        
        Timer.scheduledTimer(withTimeInterval: 8, repeats: true, block: { (timer) in
            
            if let coordinates = self.managerLocation.location?.coordinate {
                let index = UInt32(self.pokemons.count)
                let pokemon = self.pokemons[ Int(arc4random_uniform(index)) ]
                
                let annotation = PokemonAnotacao(coordinate: coordinates, pokemon: pokemon )
                
                let randomLatitude = (Double( arc4random_uniform(200) ) - 100.0) / 50000.0
                let randomLongitude = (Double( arc4random_uniform(200) ) - 100.0) / 50000.0
                
                annotation.coordinate.latitude += randomLatitude
                annotation.coordinate.longitude += randomLongitude
                self.mapView.addAnnotation( annotation )
            }
        })
    }
}
