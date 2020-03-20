//
//  AddNotePresenter.swift
//  Notas Diarias
//
//  Created by Daniel Gx on 19/03/20.
//  Copyright © 2020 Growup. All rights reserved.
//

import Foundation
import CoreData

// MARK: -Protocols

protocol PresenterView: class {
    func atualizarAnotacao()
    func salvarAnotacao()
    func improveUiKit() -> AppDelegate
    func keyboardConfig()
}

class Presenter {
    
    // MARK: -Variables
    
    weak var view: PresenterView?
    
    init(with view: PresenterView) {
        self.view = view
    }
    
    //retorna um context do tipo NSManagerObjectContext para coredata
    func returnDelegate() -> NSManagedObjectContext {
        let app = view?.improveUiKit()
        return app!.persistentContainer.viewContext
    }
    
}
