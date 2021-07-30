//
//  ConditionViewController.swift
//  Komposku
//
//  Created by Clara Anggraini on 30/07/21.
//

import UIKit

class ConditionViewController: UIViewController {

    @IBOutlet weak var conditionTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: ConditionTableViewCell.identifier, bundle: nil)
        conditionTV.register(nibCell, forCellReuseIdentifier: ConditionTableViewCell.identifier)
        conditionTV.separatorStyle = .none
        conditionTV.delegate = self
        conditionTV.dataSource = self
       
    }
}

extension ConditionViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = conditionTV.dequeueReusableCell(withIdentifier: ConditionTableViewCell.identifier, for: indexPath) as! ConditionTableViewCell
        return cell
    }
    
    
}
