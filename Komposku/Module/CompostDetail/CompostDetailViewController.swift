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
    
    @IBOutlet weak var navImageView: UIImageView!
    
    @IBOutlet weak var backBtnBg: UILabel!
    
    @IBAction func checkCondition(_ sender: Any) {
        let latestProcess = getLatestProcess()
        
        let vc = ConditionViewController(nibName: "ConditionViewController", bundle: nil)
        vc.process = latestProcess
        vc.extendProcess = processes[5].isDone
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    
    var compDetail: Compost?
    var processes: [Process] = []
    var latestProcess: Process?
    var today = Date()
    
    fileprivate func setupTableView() {
        processTV.delegate = self
        processTV.dataSource = self
        processTV.contentInset = UIEdgeInsets(top: -28, left: 0, bottom: 0, right: 0)
        let compDetailNibCell = UINib(nibName: ProcessTableViewCell.identifier, bundle: nil)
        processTV.register(compDetailNibCell, forCellReuseIdentifier: ProcessTableViewCell.identifier)
        processTV.reloadData()
    }
    
    fileprivate func setupNavigationBar() {
        
        navImageView.layer.cornerRadius = 20
        navImageView.layer.masksToBounds = true
        navImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
    }
    
    fileprivate func checkCompostMixInterval(_ latestProcess: Process) {
        if latestProcess.detail == "Aduk dan cek kondisi"{
            if !latestProcess.isDone{
                processReportLbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
                processReportLbl.text = "Kamu belum melakukan pengadukan dan pengecekan kondisi."
               
                checkBtn.isHidden = false
                checkBtn.setTitle("Cek Kondisi", for: .normal)
            }else{
                processReportLbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                processReportLbl.text = "Kamu telah menyelesaikan pengecekan."
                checkBtn.isHidden = true
            }
        }else if latestProcess.detail == "Perpanjang"{
            processReportLbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            processReportLbl.text = "Kamu telah melakukan perpanjangan kompos."
            checkBtn.isHidden = true
        }
    }
    
    fileprivate func setupView(_ unwrappedCompDetail: Compost) {
        compostNameLbl.text = unwrappedCompDetail.name
        
        let harvest_day = dateDiff(from: today, to: unwrappedCompDetail.estimated_date!).day! + 1
        statusLbl.text = "Siap panen dalam \(harvest_day) hari"
        
        moistureLbl.text = String(format: "%.2f",unwrappedCompDetail.moisture) + "%"
        
        processes = CoreDataManager.shared.getAllProcess(from: compDetail!)
        
        checkBtn.isHidden = true
        
        checkConditionView.layer.cornerRadius = 30
        checkConditionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        checkConditionView.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1.0)
        
        guard let unwrappedPhoto = compDetail?.photo else {return}
        guard let decodedData = Data(base64Encoded: unwrappedPhoto) else {return}
        navImageView.image = UIImage(data: decodedData)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setupNavigationBar()
        
        guard let unwrappedCompDetail = compDetail else {return}

        setupView(unwrappedCompDetail)
        
        setupTableView()
        
        latestProcess = getLatestProcess()
        
        checkCompostCreatedInterval(latestProcess!)
        
        checkCompostMixInterval(latestProcess!)
        
        checkCompostHarvestTime(latestProcess!)
        
    }
    
    @objc func willEnterForeground(){
        
        viewWillAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        backBtnBg.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        today = Date()
        guard let unwrappedComp = compDetail else {return}
        setupView(unwrappedComp)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        backBtnBg.isHidden = false
        
        latestProcess = getLatestProcess()
        
        checkCompostCreatedInterval(latestProcess!)
                
        checkCompostMixInterval(latestProcess!)
                
        checkCompostHarvestTime(latestProcess!)
        
        processes = CoreDataManager.shared.getAllProcess(from: compDetail!)
        
        processTV.reloadData()
        
        let harvest_day = dateDiff(from: today, to: processes[0].compost!.estimated_date!).day! + 1
        guard let unwrappedCompost = processes.first?.compost else {return}
        if dateDiff(from: today, to: unwrappedCompost.estimated_date ?? Date()).day! < 0 || Calendar.current.isDateInToday(unwrappedCompost.estimated_date ?? Date()) {
            statusLbl.text = "Komposmu siap panen"
        }else{
            statusLbl.text = "Siap panen dalam \(harvest_day) hari"
        }
    }
    
    func dateDiff(from startDate: Date, to endDate: Date) -> DateComponents{
        return Calendar.current.dateComponents([.day], from: startDate, to: endDate)
    }
}

extension CompostDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return processes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = processTV.dequeueReusableCell(withIdentifier: ProcessTableViewCell.identifier, for: indexPath) as! ProcessTableViewCell
        
            
        guard let unwrappedDate = processes[indexPath.section].date else{return cell}
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM"
            cell.processDateLbl.text = dateFormatter.string(from: unwrappedDate)
        cell.processDetailLbl.text = processes[indexPath.section].detail
        cell.setupProcessCell(isDone: processes[indexPath.section].isDone, process_date: unwrappedDate)
         
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return LineProcessView()
    }
    
    func getLatestProcess() -> Process{
       today = Date()
        if Calendar.current.isDateInToday((processes.last?.date!)!) || dateDiff(from: (processes.last?.date)!, to: today).day! > 0{
            return processes[processes.count-1]
        }
        for p in processes{
            guard let unwrappedDate = p.date else{return Process()}
            
            if dateDiff(from: unwrappedDate, to: today).day! < 3 {
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
        }
    }
    
    func checkCompostHarvestTime(_ latestProcess: Process){
        if latestProcess.detail == "Panen"{
            processReportLbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            processReportLbl.text = "Kamu belum melakukan pengecekkan panen komposmu."
            checkBtn.isHidden = false
            checkBtn.setTitle("Panen Kompos", for: .normal)
        }
    }
}
