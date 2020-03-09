//
//  Tarefa.swift
//  Lista de Tarefas
//
//  Created by Daniel Gomes on 10/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit


class Tarefa {
    
    let chave = "listaTarefas"
    var tarefas: [String] = []
    
    
    func remover(indice: Int){
        tarefas = listar()
        
        tarefas.remove(at: indice)
        UserDefaults.standard.set(tarefas, forKey: chave)
        
        
    }
    func salvar(tarefa: String){
        
        tarefas = listar()
        
        tarefas.append( tarefa )
        UserDefaults.standard.set(tarefas, forKey: chave)
    }
    
    func listar() -> Array<String> {
        
        let dados = UserDefaults.standard.object(forKey: chave)
        
        if dados != nil {
            return dados as! Array<String>
        
        }else{
        
            return []
            
        }
        
    }
    
    
}
