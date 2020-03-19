//
//  ViewController.swift
//  MVP - Study
//
//  Created by Daniel Gx on 18/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var presenter = Presenter(with: self)

    @IBOutlet weak var changeTextLabel: UILabel!
    
    @IBAction func tapMeButton(_ sender: Any) {
        presenter.buttonTapped()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController: PresenterView {
    
    func updateLabel() {
        changeTextLabel.text = "Fui alterado!"
        self.view.backgroundColor = .yellow
    }
}
