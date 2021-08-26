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
    var processCollection: [Process] = []
    var latestProcess: Process?
    var currDate = Date()
    
    @IBOutlet weak var compostList: UITableView!
    @IBOutlet weak var tutorialBtnTop: UIButton!
    @IBOutlet weak var illustration: UIImageView!
    @IBOutlet weak var firstLine: UILabel!
    @IBOutlet weak var secondLine: UILabel!
    @IBOutlet weak var tutorialBtnDown: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var selesaiBtn: UIButton!
    
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
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: " ", style: .plain, target: nil, action: nil)

        navigationController?.navigationBar.backIndicatorImage = UIImage(named:"backBtn")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backBtn")
        
        overrideUserInterfaceStyle = .light
        if dataCollection.isEmpty == true{
            compostList.isHidden = true
            tutorialBtnTop.isHidden = true
            editBtn.isHidden = true
            selesaiBtn.isHidden = true
        }else{
            compostList.isHidden = false
            tutorialBtnTop.isHidden = false
            illustration.isHidden = true
            firstLine.isHidden = true
            secondLine.isHidden = true
            tutorialBtnDown.isHidden = true
            editBtn.isHidden = false
            
        }
        
        dataCollection = CoreDataManager.shared.getAllCompost()
        
        tutorialBtnTop.layer.cornerRadius = 10
        tutorialBtnDown.layer.cornerRadius = 10
        self.compostList.separatorStyle = UITableViewCell.SeparatorStyle.none
        compostList.layer.masksToBounds = false

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      //  latestProcess = getLatestProcess()
        
        dataCollection = CoreDataManager.shared.getAllCompost()
        compostList.reloadData()
        self.navigationController?.navigationBar.isHidden = true
        if dataCollection.isEmpty{
            compostList.isHidden = true
            tutorialBtnTop.isHidden = true
            editBtn.isHidden = true
            selesaiBtn.isHidden = true
        }else{
            compostList.isHidden = false
            tutorialBtnTop.isHidden = false
            illustration.isHidden = true
            firstLine.isHidden = true
            secondLine.isHidden = true
            tutorialBtnDown.isHidden = true
            editBtn.isHidden = false
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
            cell.textLabel?.isEnabled = false
            cell.nextStep.text = "Sudah dipanen"
            cell.isUserInteractionEnabled = false
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
        navigationController?.navigationBar.isHidden = false
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func dateDiff(from startDate: Date, to endDate: Date) -> DateComponents{
        return Calendar.current.dateComponents([.day], from: startDate, to: endDate)
    }
    
    
    func getLatestProcess() -> Process{
       currDate = Date()
        if dateDiff(from: (processCollection.last?.date)!, to: currDate).day! + 1 >= 0{
            print("first if")
            return processCollection[processCollection.count-1]
        }
        for p in processCollection{
            guard let unwrappedDate = p.date else{
                print("second if")
                return Process()
                
            }
            
            if dateDiff(from: unwrappedDate, to: currDate).day! < 3 {
                print("third if")
                return p
            }
            
            
            
        }
        return Process()
    }
    
    
    
    
    @IBAction func editBtn(_ sender: Any) {
        editBtn.isHidden = true
        selesaiBtn.isHidden = false
    }
    
    @IBAction func selesaiBtn(_ sender: Any) {
        selesaiBtn.isHidden = true
        editBtn.isHidden = false
    }
    
    
    @IBAction func goToTutorialPage(_ sender: Any) {
        //buat function pindah ke tutorial page disini
        let controller = TutorialPageViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @IBAction func goToCreateCompostPage(_ sender: Any) {
        let controller = PreparationViewController()
        controller.created = {
            self.dataCollection = CoreDataManager.shared.getAllCompost()
            self.compostList.reloadData()
            self.checkIfListEmpty()
        }
        navigationController?.pushViewController(controller, animated: true)
        
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
