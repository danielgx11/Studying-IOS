//
//  ViewController.swift
//  Notas Diarias
//
//  Created by Daniel Gomes on 06/04/19.
//  Copyright © 2019 Growup. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    @IBOutlet weak var texto: UITextView!
    var context : NSManagedObjectContext!
   //Forcando commit     
      var anotacao : NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //configuraçao do teclado
        self.texto.becomeFirstResponder()
        
        if (self.anotacao != nil) {
            if let textoRecuperado = anotacao.value(forKey: "texto"){
                    self.texto.text = String(describing: textoRecuperado)
            }
            
        }else{
            self.texto.text = ""
        }
        
        
        context = returDelegate()
    }

    
    @IBAction func salvar(_ sender: Any) {
        
        if self.anotacao != nil {
            self.atualizarAnotacao()
        }else{
            self.salvarAnotacao()
        }
        
        
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    //retorna um context do tipo NSManagerObjectContext para coredata
    func returDelegate() -> NSManagedObjectContext {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.persistentContainer.viewContext
    }
    
    func atualizarAnotacao() {
        anotacao.setValue(self.texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao atualizar Anotaçao")
        } catch let erro {
            print("Erro ao atualizar o conteudo " + erro.localizedDescription)
        }
    }
    //Salvar anotação
    func salvarAnotacao(){
        let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        
        novaAnotacao.setValue(self.texto.text, forKey: "texto")
        novaAnotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
                print("Sucesso ao salvar Anotaçao")
        } catch let erro {
            print("Erro ao salvar o conteudo " + erro.localizedDescription)
        }
    }
}

