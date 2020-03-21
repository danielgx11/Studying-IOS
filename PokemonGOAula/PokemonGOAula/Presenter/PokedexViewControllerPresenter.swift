//
//  PokedexViewControllerPresenter.swift
//  PokemonGOAula
//
//  Created by Daniel Gx on 20/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import Foundation

protocol PokedexViewPresenter: class {}

class PokedexViewControllerPresenter {
    weak var view: PokedexViewPresenter?
    
    init(with view: PokedexViewPresenter) {
        self.view = view
    }
}
