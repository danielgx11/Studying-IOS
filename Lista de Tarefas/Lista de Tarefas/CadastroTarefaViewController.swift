//
//  CadastroTarefaViewController.swift
//  Lista de Tarefas
//
//  Created by Daniel Gomes on 10/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit

class CadastroTarefaViewController: UIViewController {

    @IBOutlet weak var txtTarefa: UITextField!
    
    @IBAction func btnCadastroTarefa(_ sender: Any) {
        
        if let textoDigitado = txtTarefa.text {
            
            let tarefa = Tarefa()
            tarefa.salvar(tarefa: textoDigitado)
            txtTarefa.text = ""
            let dados = tarefa.listar()
            print(dados)
        }
        
    }
    
    //esconde o teclado.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
