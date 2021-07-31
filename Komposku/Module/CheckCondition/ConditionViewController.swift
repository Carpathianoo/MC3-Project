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
            CoreDataManager.shared.extendProcess(from: (process?.compost)!)
//            let vc = CompostDetailViewController(nibName: "CompostDetailViewController", bundle: nil)
            
            navigationController?.popViewController(animated: true)
        }else{
//            navigationController?.pushViewController(ResultViewController(), animated: true)
        }

    }
    
    @IBOutlet weak var upperBtn: UIButton!
    @IBOutlet weak var lowerBtn: UIButton!
    let seeder = Seeder()
    var conditions: [Condition] = []
    var process: Process?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let composts = CoreDataManager.shared.getAllCompost()
//        process = CoreDataManager.shared.getAllProcess(from: composts[0])[0]
        upperBtn.layer.cornerRadius = 8
        lowerBtn.layer.cornerRadius = 8
        
        if process?.detail == "Panen"{
            titleLbl.text = "Hari ini panen ‘\(process?.compost?.name ?? "")’"
            conditions = seeder.seedHarvestCondition()
            
            upperBtn.setTitle("Perpanjang", for: .normal)
            upperBtn.isEnabled = false
            lowerBtn.isHidden = false
            
            upperBtn.layer.backgroundColor = UIColor(red: 214/255, green: 212/255, blue: 212/255, alpha: 1.0).cgColor
            upperBtn.tintColor = UIColor.darkGray
    
        }else{
            titleLbl.text = "Cek kondisi kompos '\(process?.compost?.name ?? "")'"
            upperBtn.setTitle("Cek Kondisi", for: .normal)
            conditions = seeder.seedCondition()
            lowerBtn.isHidden = true
        }
        
        let nibCell = UINib(nibName: ConditionTableViewCell.identifier, bundle: nil)
        
        conditionTV.register(nibCell, forCellReuseIdentifier: ConditionTableViewCell.identifier)
        conditionTV.separatorStyle = .none
        conditionTV.delegate = self
        conditionTV.dataSource = self
        conditionTV.allowsMultipleSelection = true
        conditionTV.isUserInteractionEnabled = true
    }
    
    func checkSelected(){
        var noneIsChecked = true
        if upperBtn.titleLabel?.text == "Perpanjang"{
            for c in conditions{
                if c.isChecked == true{
                    noneIsChecked = false
                    upperBtn.isEnabled = true
                    upperBtn.setEnabledView()
                    lowerBtn.isEnabled = false
                    lowerBtn.setDisabledView()
                    break
                }
            }
            if noneIsChecked{
                upperBtn.isEnabled = false
                upperBtn.setDisabledView()
                lowerBtn.isEnabled = true
                lowerBtn.setEnabledView()
            }
        }
        
        
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
            self.checkSelected()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 12
        }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                headerView.backgroundColor = .white

        return headerView
    }
    
}
extension UIButton{
    func setDisabledView(){
        layer.backgroundColor = UIColor(red: 214/255, green: 212/255, blue: 212/255, alpha: 1.0).cgColor
        tintColor = UIColor.darkGray
    }
    
    func setEnabledView(){
        layer.backgroundColor = UIColor(red: 49/255, green: 151/255, blue: 103/255, alpha: 1.0).cgColor
        tintColor = UIColor.white
    }
}
