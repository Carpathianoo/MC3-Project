//
//  ConditionViewController.swift
//  Komposku
//
//  Created by Clara Anggraini on 30/07/21.
//

import UIKit

class ConditionViewController: UIViewController {

    @IBOutlet weak var conditionTV: UITableView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBAction func checkCondition(_ sender: Any) {
        if upperBtn.titleLabel?.text == "Perpanjang"{
            CoreDataManager.shared.extendProcess(from: (process?.compost)!, date: Date())
            navigationController?.popViewController(animated: true)
            
        }else{
            let uncheckedConditions = getUncheckedCondition()
            if uncheckedConditions.isEmpty{
                let vc = DoneCheckingViewController()
                
                guard let unwrappedProcess = process else {return}
                guard let unwrappedCompost = unwrappedProcess.compost else {return}
                
                CoreDataManager.shared.updateProcessStatus(process: process!)
                
                vc.process = process
                navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = CheckingResultsPageController()
                vc.uncheckedCondition = uncheckedConditions
                vc.latestProcess = process
                //untuk button check condition kirim unchecked conditions ke result page
                navigationController?.pushViewController(vc, animated: true)
            }
            
        }

    }
    
    @IBAction func harvestCompost(_ sender: Any) {
        guard let unwrappedProcess = process else{return}
        CoreDataManager.shared.updateProcessStatus(process: unwrappedProcess)
        navigationController?.popToRootViewController(animated: true)
    }
    @IBOutlet weak var upperBtn: UIButton!
    @IBOutlet weak var lowerBtn: UIButton!
    
    let seeder = Seeder()
    var conditions: [Condition] = []
    var process: Process?
    var extendProcess: Bool = false
    
    fileprivate func setupTableView() {
        let nibCell = UINib(nibName: ConditionTableViewCell.identifier, bundle: nil)
        conditionTV.register(nibCell, forCellReuseIdentifier: ConditionTableViewCell.identifier)
        conditionTV.separatorStyle = .none
        conditionTV.delegate = self
        conditionTV.dataSource = self
        conditionTV.allowsMultipleSelection = true
        conditionTV.isUserInteractionEnabled = true
        conditionTV.backgroundColor = UIColor.white
    }
    
    fileprivate func setupBtn() {
        upperBtn.layer.cornerRadius = 8
        lowerBtn.layer.cornerRadius = 8
        if process?.detail == "Panen"{
            titleLbl.text = "Hari ini panen \"\(process?.compost?.name ?? "")\""
            conditions = seeder.seedHarvestCondition()
            
            upperBtn.setTitle("Perpanjang", for: .normal)
            upperBtn.setEnabledView()
            lowerBtn.isHidden = false
            lowerBtn.setDisabledView()
            
        }else{
            titleLbl.text = "Cek kondisi kompos \"\(process?.compost?.name ?? "")\""
            upperBtn.setTitle("Lihat Solusi", for: .normal)
            conditions = seeder.seedCondition()
            upperBtn.setEnabledView()
            lowerBtn.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        setupBtn()
        if extendProcess == true{
            conditions.remove(at: 1)
        }
        setupTableView()
    }
    
    func checkSelected(){
        var countChecked = 0
        for c in conditions{
            if c.isChecked{
                countChecked += 1
            }
        }
        if countChecked == 4{
            upperBtn.setDisabledView()
            lowerBtn.setEnabledView()
        }else{
            upperBtn.setEnabledView()
            lowerBtn.setDisabledView()
        }
    }
    
    func getUncheckedCondition()->[Int]{
        var uncheckedConditions: [Int] = []
        var index = 0
        for c in conditions{
            if !c.isChecked{
                uncheckedConditions.append(index)
            }
            index += 1
        }
        return uncheckedConditions
    }
}

extension ConditionViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return conditions.count
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = conditionTV.dequeueReusableCell(withIdentifier: ConditionTableViewCell.identifier, for: indexPath) as! ConditionTableViewCell
        cell.conditionLbl.text = conditions[indexPath.section].desc
        cell.checkListCondition = {
            if cell.checkListBtn.isSelected{
                self.conditions[indexPath.section].isChecked = true
            }else{
                self.conditions[indexPath.section].isChecked = false
            }
            if self.upperBtn.titleLabel?.text == "Perpanjang"{
                self.checkSelected()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0
        }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                headerView.backgroundColor = .white

        return headerView
    }
    
}
extension UIButton{
    func setDisabledView(){
        isEnabled = false
        layer.backgroundColor = UIColor(red: 214/255, green: 212/255, blue: 212/255, alpha: 1.0).cgColor
        tintColor = UIColor.darkGray
    }
    
    func setEnabledView(){
        isEnabled = true
        layer.backgroundColor = UIColor(red: 49/255, green: 151/255, blue: 103/255, alpha: 1.0).cgColor
        tintColor = UIColor.white
    }
}
