//
//  ListagemTableViewController.swift
//  Notas Diarias
//
//  Created by Daniel Gomes on 06/04/19.
//  Copyright © 2019 Growup. All rights reserved.
//

import UIKit
import CoreData

class ListagemTableViewController: UITableViewController {
  
    var context : NSManagedObjectContext!
    var anotacoes : [NSManagedObject] = []
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = returDelegate()
    
    }
    
    //retorna um context do tipo NSManagerObjectContext para coredata
    func returDelegate() -> NSManagedObjectContext {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.persistentContainer.viewContext
    }
    
    func recuperarAnotacoes() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Anotacao")
        
        //Ordenando dados do array
        let ordenacao = NSSortDescriptor(key: "Data", ascending: false)
        request.sortDescriptors = [ordenacao]
        
        do {
             let anotacoesRecuperadas = try context.fetch(request)
             self.anotacoes = anotacoesRecuperadas as! [ NSManagedObject ]
             self.tableView.reloadData()
            
        } catch let erro  {
            print("Erro ao recuperar anotacoes" + erro.localizedDescription)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.recuperarAnotacoes()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.anotacoes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)

        
        let anotacao = self.anotacoes [ indexPath.row ]
        let texto = anotacao.value(forKey: "texto")
        let data = anotacao.value(forKey: "data")
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-yyyy H:mm:ss"
        
        let novaData = dateFormatter.string(from: data as! Date)
        
        celula.textLabel?.text = texto as? String
        celula.detailTextLabel?.text = String(describing: novaData)
        
        return celula
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let anotacaoClicada = self.anotacoes [indexPath.row ]
        
        self.performSegue(withIdentifier: "verAnotacao", sender: anotacaoClicada)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verAnotacao" {
            let viewDestino = segue.destination as! ViewController
            
            viewDestino.anotacao = sender as? NSManagedObject
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            // 1 deletar do banco
            let indice = indexPath.row //pega o indice da linha
            let anotacao = self.anotacoes [indice] //pega o elemento
            self.context.delete(anotacao) // deleta este elemento no banco
            
            // 2 deletar do array
            self.anotacoes.remove(at: indice) //remove do array
            
            
            
            // 3 deletar o item da tabela
            tableView.deleteRows(at: [indexPath], with: .fade) //apaga o elemento na linha
            
            do{
                try self.context.save()
            }catch let erro {
                print("erro ao remover o item \(erro)")
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
