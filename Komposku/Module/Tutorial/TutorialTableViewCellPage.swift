//
//  TutorialTableViewCellPage.swift
//  Komposku
//
//  Created by Fernando Lawrence on 28/07/21.
//

import UIKit

class TutorialTableViewCellPage: UITableViewCell {

    @IBOutlet weak var viewTableTutorial: UIView!
    @IBOutlet weak var imageTableTutorial: UIImageView!
    @IBOutlet weak var labelTitleTableTutorial: UILabel!
    
    var pageShow: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //viewTableTutorial.
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
