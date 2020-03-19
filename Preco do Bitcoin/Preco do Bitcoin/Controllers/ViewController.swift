//
//  ViewController.swift
//  Preco do Bitcoin
//
//  Created by Daniel Gomes on 21/03/19.
//  Copyright © 2019 Growup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var presenter = BitcoinPricePresenter(with: self)

    @IBOutlet weak var btnTxtAtualizar: UIButton!
    @IBOutlet weak var txtPreco: UILabel!
    @IBAction func btnAtualizar(_ sender: Any) {
        self.recuperaPrecoBitcoin()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: PresenterView {
    
    func recuperaPrecoBitcoin(){
        self.btnTxtAtualizar.setTitle("Atualizando...", for: .normal)
        if let urlApi = URL(string: "https://blockchain.info/ticker"){
            let tarefa = URLSession.shared.dataTask(with: urlApi) { (dataApi, requestCode, error) in
                if error == nil {
                    if let dadosRetorno = dataApi{
                        do{
                            if let objectJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: []) as? [String : Any] {
                                if let brl = objectJson["BRL"] as? [String : Any] {
                                    if let preco = brl["buy"] as? Double{
                                        //sempre que for atualizar algum elemento na interface será preciso colocar dentro de uma tread
                                        DispatchQueue.main.async(execute: {
                                            self.txtPreco.text = "R$ " + self.presenter.formatarPreco(preco: NSNumber(value: preco))
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

