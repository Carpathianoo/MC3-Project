//
//  SolutionTableViewCell.swift
//  Komposku
//
//  Created by Clara Anggraini on 30/07/21.
//

import UIKit

class SolutionTableViewCell: UITableViewCell {

    @IBOutlet weak var subtitleLbl: UILabel!
    @IBOutlet weak var solDetailLbl: UILabel!
    static let identifier = "SolutionTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
