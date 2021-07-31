//
//  DoneCheckingViewController.swift
//  Komposku
//
//  Created by Clara Anggraini on 30/07/21.
//

import UIKit

class DoneCheckingViewController: UIViewController {
    @IBAction func returnToCompost(_ sender: Any) {
        navigationController?.popToViewController((navigationController?.viewControllers[0])!, animated: true)
    }
    
    var process: Process?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
    }

}
