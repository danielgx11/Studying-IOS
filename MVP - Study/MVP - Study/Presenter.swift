//
//  Presenter.swift
//  MVP - Study
//
//  Created by Daniel Gx on 18/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import Foundation

protocol PresenterView: class {
    func updateLabel()
}

class Presenter {
    weak var view: PresenterView?
    
    // Pass something that conforms to PresenterView
    
    init(with view: PresenterView) {
        self.view = view
    }
    
    var timesTapped = 0
    
    func buttonTapped() {
        timesTapped += 1
        
        if timesTapped >= 5 {
            self.view?.updateLabel()
        }
    }
    
}
