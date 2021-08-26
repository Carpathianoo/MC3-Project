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
    @IBOutlet weak var viewShadowTutorial: UIView!
    
    var pageShow: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupView() {
        imageTableTutorial.layer.cornerRadius = 12
        imageTableTutorial.accessibilityIgnoresInvertColors = true
        viewTableTutorial.layer.cornerRadius = 12

        viewShadowTutorial.addGradientBackground(firstColor: .clear, secondColor: .black)
        viewShadowTutorial.layer.cornerRadius = 12
    }

    
}
