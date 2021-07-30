//
//  ConditionTableViewCell.swift
//  Komposku
//
//  Created by Clara Anggraini on 30/07/21.
//

import UIKit

class ConditionTableViewCell: UITableViewCell {

    @IBOutlet weak var conditionLbl: UILabel!
    @IBOutlet weak var statusIV: UIImageView!
    static let identifier = "ConditionTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
