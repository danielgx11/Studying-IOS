//
//  NotesTableViewListPresenter.swift
//  Notas Diarias
//
//  Created by Daniel Gx on 19/03/20.
//  Copyright © 2020 Growup. All rights reserved.
//

import Foundation
import CoreData

protocol PresenterTableView: class {
    func improveUiKit() -> AppDelegate
    func recuperarAnotacoes()
    func returDelegate() -> NSManagedObjectContext
}

class NotesTableViewListPresenter {
    
    weak var tableView: PresenterTableView?
    
    init(with tableView: PresenterTableView) {
        self.tableView = tableView
    }
    
    func returDelegate() -> NSManagedObjectContext {
        let app = tableView?.improveUiKit()
        return (app?.persistentContainer.viewContext)!
    }
}
