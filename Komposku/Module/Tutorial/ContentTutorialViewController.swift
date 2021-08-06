//
//  ContentTutorialViewController.swift
//  Komposku
//
//  Created by Fernando Lawrence on 28/07/21.
//

import UIKit

class ContentTutorialViewController: UIViewController {

    
    @IBOutlet weak var TitleContentTutorialLabel: UILabel!
    @IBOutlet weak var ImageContentTutorial: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }


}
