//
//  CompostDetailViewController.swift
//  Komposku
//
//  Created by Clara Anggraini on 29/07/21.
//

import UIKit

class CompostDetailViewController: UIViewController {

    @IBOutlet weak var compostNameLbl: UILabel!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var dashedView: UIView!
    
    @IBOutlet weak var processTV: UITableView!
    
    @IBOutlet weak var moistureLbl: MoistureLabel!
    
    @IBOutlet weak var checkConditionView: UIView!
    
    @IBOutlet weak var processReportLbl: UILabel!
    
    @IBOutlet weak var checkBtn: CustomButton!
    
    @IBAction func checkCondition(_ sender: Any) {
        let latestProcess = getLatestProcess()
        
        let vc = ConditionViewController(nibName: "ConditionViewController", bundle: nil)
        vc.process = latestProcess

        navigationController?.pushViewController(vc, animated: true)
    }
    
    var compDetail: Compost?
    var processes: [Process] = []
    
    fileprivate func setupTableView() {
        processTV.delegate = self
        processTV.dataSource = self
        
        let compDetailNibCell = UINib(nibName: ProcessTableViewCell.identifier, bundle: nil)
        processTV.register(compDetailNibCell, forCellReuseIdentifier: ProcessTableViewCell.identifier)
        processTV.reloadData()
    }
    
    fileprivate func setupNavigationBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundImage = UIImage(named: (compDetail?.photo) ?? "")
            
            self.navigationController!.navigationBar.standardAppearance = navBarAppearance
            self.navigationController!.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        checkConditionView.layer.cornerRadius = 30
        checkConditionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        checkConditionView.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1.0)
        
    }
    
    fileprivate func checkCompostMixInterval(_ latestProcess: Process) {
        if latestProcess.detail == "Aduk dan cek kondisi"{
            if !latestProcess.isDone{
                processReportLbl.text = "Kamu belum melakukan pengadukan dan pengecekan kondisi."
                checkBtn.isHidden = false
                checkBtn.setTitle("Cek Kondisi", for: .normal)
            }else{
                processReportLbl.text = "Kamu telah menyelesaikan pengecekan."
            }
            
        }else if latestProcess.isDone{
            checkBtn.isHidden = true
        }
    }
    
    fileprivate func setupView(_ unwrappedCompDetail: Compost) {
        compostNameLbl.text = unwrappedCompDetail.name
        
        let harvest_day = dateDiff(from: Date(), to: unwrappedCompDetail.estimated_date!)
        statusLbl.text = "Siap panen dalam \(harvest_day.day!) hari"
        
        moistureLbl.text = String(unwrappedCompDetail.moisture) + "%"
        
        processes = CoreDataManager.shared.getAllProcess(from: compDetail!)
        
        checkBtn.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setupNavigationBar()
//        CoreDataManager.shared.createCompost(name: "Kompos Pertamaku", photo: "Comp-1", moisture: 56.7)
        
        compDetail = CoreDataManager.shared.getAllCompost()[0]
        
        guard let unwrappedCompDetail = compDetail else {return}
        
        setupView(unwrappedCompDetail)
        
        setupTableView()
        
        let latestProcess = getLatestProcess()
        
//        checkCompostCreatedInterval(latestProcess)
        
        checkCompostMixInterval(latestProcess)
        
        checkCompostHarvestTime(latestProcess)
        
    }
    
    func dateDiff(from startDate: Date, to endDate: Date) -> DateComponents{
        return Calendar.current.dateComponents([.day], from: startDate, to: endDate)
    }
}

extension CompostDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let unwrappedProcess = compDetail?.process else{return 0}
        return unwrappedProcess.count * 2 - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0{
            var index = indexPath.row / 2
            if indexPath.row == 0{
                index = 0
            }
            let cell = processTV.dequeueReusableCell(withIdentifier: ProcessTableViewCell.identifier, for: indexPath) as! ProcessTableViewCell
            guard let unwrappedDate = processes[index].date else{return cell}
            
            cell.setupProcessCell(isDone: processes[index].isDone, process_date: unwrappedDate)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM"
            
            cell.processDateLbl.text = dateFormatter.string(from: unwrappedDate)
            cell.processDetailLbl.text = processes[index].detail
            
            index = indexPath.row / 2 - 1
            return cell
        }else{
            let lineCell = processTV.dequeueReusableCell(withIdentifier: ProcessTableViewCell.identifier, for: indexPath) as! ProcessTableViewCell
            
            lineCell.setupLine()
            return lineCell
        }
    }
    
    func getLatestProcess() -> Process{
        if dateDiff(from: (processes.last?.date)!, to: (processes.last?.date!)!).day == 0{
            
            return processes[processes.count-1]
        }
        for p in processes{
            guard let unwrappedDate = p.date else{return Process()}
            
            if dateDiff(from: unwrappedDate, to: Date()).day! < 3 {
                return p
            }
        }
        return Process()
    }
    
    func getUpcomingProcess() -> Process{
        for p in processes{
            guard let unwrappedDate = p.date else{return Process()}
            if Calendar.current.isDateInTomorrow(unwrappedDate){
                return p
            }
        }
        return Process()
    }
    
    func checkCompostCreatedInterval(_ latestProcess: Process){
        let dateDiffValue = dateDiff(from: processes[0].date!, to: latestProcess.date!).day!

        if(dateDiffValue + 1 < 3){
            processReportLbl.text = "Kompos telah dibuat"
            processReportLbl.font = UIFont.boldSystemFont(ofSize: 20)
            processReportLbl.centerYAnchor.constraint(equalTo: checkConditionView.centerYAnchor).isActive = true

        }
    }
    

    
    func checkCompostHarvestTime(_ latestProcess: Process){
        if latestProcess.detail == "Panen"{
            processReportLbl.text = "Kamu belum melakukan pengecekkan panen komposmu."
            checkBtn.isHidden = false
            checkBtn.setTitle("Panen Kompos", for: .normal)
        }
    }
}
