//
//  ViewController.swift
//  Preco do Bitcoin
//
//  Created by Daniel Gomes on 21/03/19.
//  Copyright © 2019 Growup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnTxtAtualizar: UIButton!
    @IBOutlet weak var txtPreco: UILabel!
    @IBAction func btnAtualizar(_ sender: Any) {
        self.recuperaPrecoBitcoin()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func formatarPreco(preco : NSNumber) -> String{
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "pt_BR")
        
        if let precoFinal = nf.string(from: preco){
            return precoFinal
        }
        return "0,00"
    }
    
    func recuperaPrecoBitcoin(){
        //alterar texto do botão
        self.btnTxtAtualizar.setTitle("Atualizando...", for: .normal)
        //ulr da api
        if let urlApi = URL(string: "https://blockchain.info/ticker"){
            //metodo para receber os dados da api
            let tarefa = URLSession.shared.dataTask(with: urlApi) { (dataApi, requestCode, error) in
                //verifica se não deu erro
                if error == nil {
                    //passa os dados da api para uma nova variavel
                    if let dadosRetorno = dataApi{
                        //aqui é um trycatch
                        do{
                            //trata o dado passsando para json. e tem que converter para um dicionario.
                            if let objectJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: []) as? [String : Any] {
                                //passa o conteudo da chave para nova variavel. tem que converter em dicionario
                                if let brl = objectJson["BRL"] as? [String : Any] {
                                    //passa o conteudo para nova variavel e converte o dado no dado que vocë vai utlizar.
                                    if let preco = brl["buy"] as? Double{
                                        
                                        //sempre que for atualizar algum elemento na interface será preciso colocar dentro de uma tread
                                        DispatchQueue.main.async(execute: {
                                                self.txtPreco.text = "R$ " + self.formatarPreco(preco: NSNumber(value: preco))
                                                self.btnTxtAtualizar.setTitle("Atualizar", for: .normal)
                                        })
                                        
                                        
                                    }
                                }
                            }
                            
                        }catch{
                            print("Error ao formatar Json")
                        }
                    }
                    
                }else{
                    print("Error ao fazer consulta do preço")
                }
            }
            
            tarefa.resume()
        }
    }

}

