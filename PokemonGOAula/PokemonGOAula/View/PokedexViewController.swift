//
//  PokedexViewController.swift
//  PokemonGOAula
//
//  Created by Daniel Gx.
//  Copyright © Daniel Gx. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController {
    
    // MARK: -Variables
    
    lazy var presenter = PokedexViewControllerPresenter(with: self)
    var capturedPokemons: [Pokemon] = []
    var dontCapturedPokemons: [Pokemon] = []
    
    // MARK: -Actions Button

    @IBAction func voltarMapa(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil )
    }
    
    // MARK: -Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataPokemons()
    }
    
    func coreDataPokemons() {
        let coreDataPokemon = CoreDataPokemon()
        capturedPokemons = coreDataPokemon.recoveredCapturedPokemons(captured: true)
        dontCapturedPokemons = coreDataPokemon.recoveredCapturedPokemons(captured: false)
    }
}

// MARK: -TableView datasource & delegate

extension PokedexViewController: UITableViewDelegate, UITableViewDataSource, PokedexViewPresenter {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Capturados"
        }else{
            return "Não Capturados"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return capturedPokemons.count
        }else{
            return dontCapturedPokemons.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pokemon: Pokemon
        if indexPath.section == 0 {
            pokemon = capturedPokemons[indexPath.row]
        }else{
            pokemon = dontCapturedPokemons[indexPath.row]
        }
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "celula")
        //let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        cell.textLabel?.text = pokemon.nome
        cell.imageView?.image = UIImage(named: pokemon.nomeImagem!)
        
        return cell
    }
}
