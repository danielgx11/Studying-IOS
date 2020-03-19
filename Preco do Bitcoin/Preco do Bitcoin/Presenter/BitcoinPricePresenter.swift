//
//  BitcoinPricePresenter.swift
//  Preco do Bitcoin
//
//  Created by Daniel Gx on 19/03/20.
//  Copyright © 2020 Growup. All rights reserved.
//

import Foundation

protocol PresenterView: class {
    func recuperaPrecoBitcoin()
}

class BitcoinPricePresenter {
    
    weak var view: PresenterView?
    
    init(with view: PresenterView) {
        self.view = view
    }
    
    func formatarPreco(preco: NSNumber) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "pt_BR")
        
        if let precoFinal = nf.string(from: preco){
            return precoFinal
        }
        return "0,00"
    }
    
}
