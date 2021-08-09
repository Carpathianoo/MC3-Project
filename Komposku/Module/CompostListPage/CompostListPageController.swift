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
  
    
//    let firstData = ListModel(title: "Kompos Pertama Ku", nextStep: "Aduk dan cek kondisi", estimasiPanen: "2 hari lagi", foto: #imageLiteral(resourceName: "compost1"))
//    let secondData = ListModel(title: "Kompos Ku Tercinta", nextStep: "Aduk dan cek kondisi", estimasiPanen: "3 hari lagi", foto: #imageLiteral(resourceName: "compost3"))
//    let thirdData = ListModel(title: "Kompos Yang Mantap", nextStep: "Aduk dan aduk - aduk", estimasiPanen: "5 hari lagi", foto: #imageLiteral(resourceName: "compost2"))

    
    var dataCollection: [Compost] = []
    var latestProcess: Process?
    
    @IBOutlet weak var compostList: UITableView!
    @IBOutlet weak var tutorialBtnTop: UIButton!
    @IBOutlet weak var illustration: UIImageView!
    @IBOutlet weak var firstLine: UILabel!
    @IBOutlet weak var secondLine: UILabel!
    @IBOutlet weak var tutorialBtnDown: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupData()
        setupView()
    
        
        let nib = UINib(nibName: "CompostTableViewCell" , bundle: nil)
        compostList.register(nib, forCellReuseIdentifier: "CompostListCell")
        compostList.delegate = self
        compostList.dataSource = self
    }
    
    func setupView(){
        navigationController?.setNavigationBarHidden(true, animated: false)
        overrideUserInterfaceStyle = .light
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
        
        dataCollection = CoreDataManager.shared.getAllCompost()
        
        tutorialBtnTop.layer.cornerRadius = 10
        tutorialBtnDown.layer.cornerRadius = 10
        self.compostList.separatorStyle = UITableViewCell.SeparatorStyle.none
        compostList.layer.masksToBounds = false

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataCollection = CoreDataManager.shared.getAllCompost()
        compostList.reloadData()
        if dataCollection.isEmpty{
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
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = compostList.dequeueReusableCell(withIdentifier: "CompostListCell", for: indexPath) as! CompostTableViewCell
        cell.selectionStyle = .none
        cell.compostTitle.text = dataCollection[indexPath.row].name
        guard let unwrappedPhoto = dataCollection[indexPath.row].photo else {return cell}
        if unwrappedPhoto != "complist"{
            guard let decodedData = Data(base64Encoded: unwrappedPhoto) else {return cell}
            let newImage = UIImage(data: decodedData)
            cell.compostImage.image = newImage
        }else{
            let newImage = UIImage(named: dataCollection[indexPath.row].photo!)
            cell.compostImage.image = newImage
        }
        
        latestProcess = getLatestProcess(compost: dataCollection[indexPath.row])
        guard let unwrappedLatestProcess = latestProcess else {return cell}
        if latestProcess?.detail == "Panen" && latestProcess?.isDone == true{
            cell.isUserInteractionEnabled = false
            cell.textLabel?.isEnabled = false
            cell.nextStep.text = "Sudah dipanen"
            
        }else{
            cell.nextStep.text = unwrappedLatestProcess.detail
        }

        cell.estimasiPanen.text = calculateLatestProcessDate(latest: unwrappedLatestProcess)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        //buat code pindah ke detail compost page disini
        let vc = CompostDetailViewController()
        vc.compDetail = dataCollection[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func goToTutorialPage(_ sender: Any) {
        //buat function pindah ke tutorial page disini
        let controller = TutorialPageViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @IBAction func goToCreateCompostPage(_ sender: Any) {
        let controller = CreateCompostViewController()
        let nav = UINavigationController(rootViewController: controller)
        controller.textFieldStatus = false
        controller.isDismissed = {
            self.dataCollection = CoreDataManager.shared.getAllCompost()
            self.compostList.reloadData()
            self.checkIfListEmpty()
        }
        present(nav, animated: true, completion: nil)
        
    }
    
    func checkIfListEmpty(){
        if dataCollection.isEmpty{
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
    }
    
    func calculateLatestProcessDate(latest: Process) -> String{
        let today = Date()
        
        if latest.isDone == true{
            return "Selesai"
        }else if Calendar.current.isDateInToday(latest.date!) || Calendar.current.dateComponents([.day], from: today, to: latest.date!).day! < 0 && Calendar.current.dateComponents([.day], from: today, to: latest.date!).day! > -3{
            return "Hari ini"
        }else{
            let dateDiff = Calendar.current.dateComponents([.day], from: today, to: latest.date!).day! + 1
            return "\(dateDiff) hari lagi"
        }
        
    }
    
    func getLatestProcess(compost: Compost) -> Process{
        let processes = CoreDataManager.shared.getAllProcess(from: compost)
        let today = Date()
        if Calendar.current.dateComponents([.day], from: (processes.last?.date)!, to: today).day! > 0{
            return processes[processes.count-1]
        }
        for p in processes{
            guard let unwrappedDate = p.date else{return Process()}
            
            if Calendar.current.dateComponents([.day], from: unwrappedDate, to: today).day! < 3 {
                if p.isDone == true && p.detail != "Panen"{
                    return processes[Int(p.identifier)]
                }
                return p
            }
        }
        return processes[processes.count-1]
    }
}
