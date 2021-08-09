//
//  ViewController.swift
//  Komposku
//
//  Created by Clara Anggraini on 26/07/21.
//

import UIKit

class CompostController: UIViewController {

    @IBOutlet weak var testLbl: UILabel!
    var composts: [Compost] = []
    let coreData = CoreDataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create Compost
//        coreData.createCompost(name: "Compost 1", photo: "IMG-1", moisture: 59.3)
        
        //Get Composts
//        composts = CoreDataManager.shared.getAllCompost()
        
        var pcs = ""
        
        //extend harvest date
//        coreData.extendProcess(from: composts[0])
        
        // get all process
//        let processes = coreData.getAllProcess(from: composts[0])
        
        //display each process
//        for p in processes{
//            pcs += String(p.detail! + ": \(p.isDone)") +  "\n"
//            print(p.date!)
//        }
        
        
        testLbl.text = pcs
        
    }
}
