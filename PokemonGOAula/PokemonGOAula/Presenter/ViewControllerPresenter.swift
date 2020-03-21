//
//  ViewControllerPresenter.swift
//  PokemonGOAula
//
//  Created by Daniel Gx on 20/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import Foundation
import MapKit

protocol PresenterView: class {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    func centerLocation()
}

class ViewControllerPresenter {
    
    weak var view: PresenterView?
    
    init(with view: PresenterView) {
        self.view = view
    }
    
    var count = 0
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if count < 3 {
            view?.centerLocation()
            count += 1
        }else{
            debugPrint("stopUpdatingLocation!")
        }
    }
}
