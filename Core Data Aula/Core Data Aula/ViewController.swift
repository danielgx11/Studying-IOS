//
//  ViewController.swift
//  Core Data Aula
//
//  Created by Daniel Gomes on 05/04/19.
//  Copyright © 2019 Growup. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = getContext()
        
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuarios")
        
        //ORdenação dos dados
        let ordenacao = NSSortDescriptor(key: "nome", ascending: true)
        
        
        //Filtrando os dados com predicate
        //let predicateFormatado = NSPredicate(format: "nome == %@", "a")
        //requisicao.predicate = NSPredicate(format: "nome == %@", "Mateus Fernandes") //para consulta igual ao conteudo procurado.
        
        //let filtroA = NSPredicate(format: "nome contais [c] %@", "Fernandes")
        // let filtroB = NSPredicate(format: "nome contais [c] %@", "at")
        //combiando filtro
        // let combinacaoFiltro  = NSCompoundPredicate(andPredicateWithSubpredicates: [filtroA, filtroB])
        
        //requisicao.predicate = combinacaoFiltr\
        //requisicao.predicate = NSPredicate(format: "nome contais [c] %@", "outlook")
        //requisicao.predicate = filtroB
        //print(requisicao)
        // requisicao.predicate = combinacaoFiltro
        
        requisicao.sortDescriptors = [ordenacao]
        
        do {
            let usuarios = try context.fetch(requisicao)
            
            if usuarios.count > 0 {
                
                for usuario in usuarios as![NSManagedObject]{
                    let loginUsuario = usuario.value(forKey: "nome")
                    print(String(describing: loginUsuario))
                }
            }else{
                print("Nenhum resultado encontrad!")
            }
            
        } catch  {
            print("Erro ao listar os dados")
        }
        
        /*let Usuario = NSEntityDescription.insertNewObject(forEntityName: "Usuarios", into: context)
        
        Usuario.setValue("marialuiza@gmail.com", forKey: "login")
        Usuario.setValue("Maria Luíza Amaral Fernandes", forKey: "nome")
        Usuario.setValue("12345", forKey: "senha")
        Usuario.setValue("994635262", forKey: "telefone")
        salvaDados(context: context)*/
        
    }
    
    
    func salvaDados(context : NSManagedObjectContext){
        do {
            try context.save()
            print("Dados Salvos com sucessos!!!")
        } catch {
            print("Erro ao salvar os dados!")
        }
        
    }
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = (appDelegate?.persistentContainer.viewContext)!
        return context
    }
    
    

}

