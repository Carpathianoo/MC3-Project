//
//  ConditionTableViewCell.swift
//  Komposku
//
//  Created by Clara Anggraini on 30/07/21.
//

import UIKit

class ConditionTableViewCell: UITableViewCell {

    @IBOutlet weak var conditionLbl: UILabel!
    
    @IBOutlet weak var checkListBtn: UIButton!
    
    
    @IBAction func checkListTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        checkListCondition?()
    }
    
    var checkListCondition : (()->())?
    
    static let identifier = "ConditionTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        isUserInteractionEnabled = true
        checkListBtn.isEnabled = true
        checkListBtn.tintColor = UIColor(red: 124/255, green: 204/255, blue: 167/255, alpha: 1.0)
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
