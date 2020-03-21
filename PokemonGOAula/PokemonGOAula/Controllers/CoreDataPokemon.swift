//
//  CoreData.swift
//  PokemonGOAula
//
//  Created by Daniel Gx.
//  Copyright © Daniel Gx. All rights reserved.
//

import UIKit
import CoreData

class CoreDataPokemon {
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        return context!
    }
    
    func addAllPokemons(){
        
        self.createPokemons(name: "Pikachu", imageName: "pikachu-2", captured: true )
        self.createPokemons(name: "Squirtle", imageName: "squirtle", captured: false  )
        self.createPokemons(name: "Charmander", imageName: "charmander", captured: false  )
        self.createPokemons(name: "Caterpie", imageName: "caterpie", captured: false  )
        self.createPokemons(name: "Bullbasaur", imageName: "bullbasaur", captured: false  )
        self.createPokemons(name: "Bellsprout", imageName: "bellsprout", captured: false  )
        self.createPokemons(name: "Psyduck", imageName: "psyduck", captured: false  )
        self.createPokemons(name: "Rattata", imageName: "rattata", captured: false  )
        self.createPokemons(name: "Meowth", imageName: "meowth", captured: false  )
        self.createPokemons(name: "Snorlax", imageName: "snorlax", captured: false  )
        self.createPokemons(name: "Zubat", imageName: "zubat", captured: false  )
        
        let context = getContext()
        
        do{
            try context.save()
        }catch{}
    }
    
    func createPokemons(name: String, imageName: String, captured: Bool ){
        
        let context = self.getContext()
        let pokemon = Pokemon(context: context )
        pokemon.nome = name
        pokemon.nomeImagem = imageName
        pokemon.capturado = captured
        
    }
    
    func recoverAllPokemons() -> [Pokemon] {
        let context = self.getContext()
        
        do{
            let pokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
            
            if pokemons.count == 0 {
                addAllPokemons()
                return recoverAllPokemons()
            }
            return pokemons
        }catch{
            debugPrint("Não foi possivel adicionar/recuperar os pokemons solicitados!")
        }
        return []
    }
    
    func recoveredCapturedPokemons(captured: Bool) -> [Pokemon] {
        let context = self.getContext()
        
        let requisicao = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
        requisicao.predicate = NSPredicate(format: "capturado = %i", captured as CVarArg)
        
        do{
            let pokemons = try context.fetch( requisicao ) as [Pokemon]
            return pokemons
        }catch{}
        
        return []
    }
    
    
}
