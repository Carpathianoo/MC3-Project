//
//  CompostListPageController.swift
//  Komposku
//
//  Created by Adlan Nourindiaz on 29/07/21.
//

import Foundation
import UIKit


struct ListModel{
    
    var title: String
    var nextStep: String
    var estimasiPanen: String
    var foto: UIImage
    
    init(title: String, nextStep: String, estimasiPanen: String, foto: UIImage) {
        self.title = title
        self.nextStep = nextStep
        self.estimasiPanen = estimasiPanen
        self.foto = foto
    }
    
}



class CompostListPageController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    let firstData = ListModel(title: "Kompos Pertama Ku", nextStep: "Aduk dan cek kondisi", estimasiPanen: "2 hari lagi", foto: #imageLiteral(resourceName: "compost1"))
    let secondData = ListModel(title: "Kompos Ku Tercinta", nextStep: "Aduk dan cek kondisi", estimasiPanen: "3 hari lagi", foto: #imageLiteral(resourceName: "compost3"))
    let thirdData = ListModel(title: "Kompos Yang Mantap", nextStep: "Aduk dan aduk - aduk", estimasiPanen: "5 hari lagi", foto: #imageLiteral(resourceName: "compost2"))

    
    var dataCollection: [ListModel] = []
    
    @IBOutlet weak var compostList: UITableView!
    @IBOutlet weak var tutorialBtnTop: UIButton!
    @IBOutlet weak var illustration: UIImageView!
    @IBOutlet weak var firstLine: UILabel!
    @IBOutlet weak var secondLine: UILabel!
    @IBOutlet weak var tutorialBtnDown: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
    
        
        let nib = UINib(nibName: "CompostTableViewCell" , bundle: nil)
        compostList.register(nib, forCellReuseIdentifier: "CompostListCell")
        compostList.delegate = self
        compostList.dataSource = self
    }
    
    func setupView(){
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        if dataCollection.isEmpty == true{
            compostList.isHidden = true
            tutorialBtnTop.isHidden = true
        }else{
            compostList.isHidden = false
            tutorialBtnTop.isHidden = false
            illustration.isHidden = true
            firstLine.isHidden = true
            secondLine.isHidden = true
            tutorialBtnDown.isHidden = true
        }
        
        tutorialBtnTop.layer.cornerRadius = 10
        self.compostList.separatorStyle = UITableViewCell.SeparatorStyle.none
//        compostList.layer.cornerRadius = 8
        compostList.layer.masksToBounds = false

    }
    
    func setupData() {
        dataCollection.append(firstData)
        dataCollection.append(secondData)
        dataCollection.append(thirdData)

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = compostList.dequeueReusableCell(withIdentifier: "CompostListCell", for: indexPath) as! CompostTableViewCell
        cell.selectionStyle = .none
        cell.compostTitle.text = dataCollection[indexPath.row].title
        cell.compostImage.image = dataCollection[indexPath.row].foto
        cell.nextStep.text = dataCollection[indexPath.row].nextStep
        cell.estimasiPanen.text = dataCollection[indexPath.row].estimasiPanen
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        //buat code pindah ke detail compost page disini
//        let controller = DummyPage()
//        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @IBAction func goToTutorialPage(_ sender: Any) {
        //buat function pindah ke tutorial page disini
    }
    
    
    @IBAction func goToCreateCompostPage(_ sender: Any) {
        let controller = CreateCompostViewController()
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true, completion: nil)
    }
    
}
