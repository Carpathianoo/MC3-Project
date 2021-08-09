//
//  SolutionHeaderCell.swift
//  Komposku
//
//  Created by Adlan Nourindiaz on 05/08/21.
//

import UIKit

class SolutionHeaderCell: UITableViewCell {

    @IBOutlet weak var solutionTitle: UILabel!
    @IBOutlet weak var solutionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
