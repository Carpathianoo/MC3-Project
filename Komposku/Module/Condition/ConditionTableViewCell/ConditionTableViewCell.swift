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
//        checkListBtn.setImage(UIImage(systemName: "circle"), for: .normal)
//        checkListBtn.setImage(UIImage(named: "checkmark.circle.fill"), for: UIControl.State.selected)
        checkListBtn.tintColor = UIColor(red: 49/255, green: 151/255, blue: 103/255, alpha: 1.0)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
