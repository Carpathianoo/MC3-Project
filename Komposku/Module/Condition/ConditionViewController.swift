//
//  ConditionViewController.swift
//  Komposku
//
//  Created by Clara Anggraini on 30/07/21.
//

import UIKit

class ConditionViewController: UIViewController {

    @IBOutlet weak var conditionTV: UITableView!
    
    @IBAction func checkCondition(_ sender: Any) {
        navigationController?.pushViewController(ResultViewController(), animated: true)
    }
    let seeder = Seeder()
    var conditions: [Condition] = []
    var harvestConditions: [HarvestCondition] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conditions = seeder.seedCondition()
        harvestConditions = seeder.seedHarvestCondition()
        
        let nibCell = UINib(nibName: ConditionTableViewCell.identifier, bundle: nil)
        
        conditionTV.register(nibCell, forCellReuseIdentifier: ConditionTableViewCell.identifier)
        conditionTV.separatorStyle = .none
        conditionTV.delegate = self
        conditionTV.dataSource = self
        conditionTV.allowsMultipleSelection = true
        conditionTV.isUserInteractionEnabled = true
       
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
