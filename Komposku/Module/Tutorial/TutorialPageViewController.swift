//
//  TutorialPageViewController.swift
//  Komposku
//
//  Created by Fernando Lawrence on 28/07/21.
//

import UIKit

class TutorialPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var listTutorial = tutorialData
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleTutorial.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tutorialCell = tutorialTableView.dequeueReusableCell(withIdentifier: "tutorialCell", for: indexPath) as! TutorialTableViewCellPage
        tutorialCell.selectionStyle = .none
        tutorialCell.imageTableTutorial.image = UIImage(named: imageTutorial[indexPath.row])
        tutorialCell.labelTitleTableTutorial.text = titleTutorial[indexPath.row]
        return tutorialCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let controller = ContentTutorialViewController()
        controller.tutorial = listTutorial[indexPath.row]
        controller.index = indexPath.row
        navigationController?.pushViewController(controller, animated: true)
    }
    
    var titleTutorial:[String] = ["Material Kompos", "Cara Mengkompos", "Tips & Tricks"]
    var imageTutorial:[String] = ["Material Kompos","Cara Mengkompos","Tips and Tricks"]

    @IBOutlet weak var tutorialTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        tutorialTableView.register(UINib(nibName: "TutorialTableViewCellPage", bundle: nil), forCellReuseIdentifier: "tutorialCell")
        tutorialTableView.delegate = self
        tutorialTableView.dataSource = self
    }
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
