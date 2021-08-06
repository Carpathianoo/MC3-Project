//
//  FirstTimePageController.swift
//  Komposku
//
//  Created by Adlan Nourindiaz on 31/07/21.
//

import UIKit

class FirstTimePageController: UIViewController {

    @IBOutlet weak var tutorialButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }

    func setupView(){
        navigationController?.setNavigationBarHidden(true, animated: false)

        tutorialButton.layer.cornerRadius = 10
    }
    
    

    @IBAction func createCompost(_ sender: Any) {
        
        
        let myViewController = CompostListPageController(nibName: "CompostListPage", bundle: nil)
        myViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(myViewController, animated: true)
        
        
        //buat func ke create compost page disini
    }
    
    
    @IBAction func lihatTutorial(_ sender: Any) {
        
        //buat func ke tutorial page disini
//        let myViewController = tutorialPageController(nibName: "TutorialPageController", bundle: nil)
//        myViewController.modalPresentationStyle = .fullScreen
//        self.navigationController?.pushViewController(myViewController, animated: true)
    }
    
}
