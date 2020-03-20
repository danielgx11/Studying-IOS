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
    
    // MARK: -Variables
    
    var context : NSManagedObjectContext!
    var anotacao : NSManagedObject!
    lazy var presenter = Presenter(with: self)
    
    // MARK: -Outlets
    
    @IBOutlet weak var texto: UITextView!
    
    // MARK: -Action Buttons
    
    @IBAction func salvar(_ sender: Any) {
        if self.anotacao != nil {
            self.atualizarAnotacao()
        }else{
            self.salvarAnotacao()
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: -Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.keyboardConfig()
    }
}

// MARK: -Extensions

extension ViewController: PresenterView {
    func improveUiKit() -> AppDelegate {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app
    }
    
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
    
    func atualizarAnotacao() {
        anotacao.setValue(self.texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao atualizar Anotaçao")
        } catch let erro {
            print("Erro ao atualizar anotação: \(erro.localizedDescription)")
        }
    }
    
    func keyboardConfig() {
        self.texto.becomeFirstResponder()
        
        if (self.anotacao != nil) {
            if let textoRecuperado = anotacao.value(forKey: "texto"){
                self.texto.text = String(describing: textoRecuperado)
            }
        }else{
            self.texto.text = ""
        }
        context = presenter.returnDelegate()
    }
}
