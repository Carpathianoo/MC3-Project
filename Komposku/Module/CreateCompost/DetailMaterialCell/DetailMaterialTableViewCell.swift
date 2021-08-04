//
//  DetailMaterialTableViewCell.swift
//  Komposku
//
//  Created by Ahmad Zaky on 03/08/21.
//

import UIKit

class DetailMaterialTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var detailMaterial1: UILabel!
    @IBOutlet weak var detailMaterial2: UILabel!
    
    var bahan: Int? {
        didSet {
            if bahan == 0 {
                detailMaterial1.attributedText = StringModifier.modifyDetailMaterial(sentence: ["Bahan ", "Hijau ", "adalah bahan yang ", "kaya akan nitrogen atau protein."], color1: .black, color2: .black, bothBold: false)
                detailMaterial2.attributedText = StringModifier.modifyDetailMaterial(sentence: ["Ukur bagian ", "dengan menggunakan ", "wadah yang sama."],color1: #colorLiteral(red: 0.1921568627, green: 0.5921568627, blue: 0.4039215686, alpha: 1), color2: .black, bothBold: true)
            } else {
                detailMaterial1.attributedText = StringModifier.modifyDetailMaterial(sentence: ["Bahan ", "Cokelat ", "adalah bahan yang ", "kaya akan karbon atau karbohidrat."], color1: .black,color2: .black, bothBold: false)
                detailMaterial2.attributedText = StringModifier.modifyDetailMaterial(sentence: ["Ukur bagian ", "dengan menggunakan ", "wadah yang sama."], color1: #colorLiteral(red: 0.1921568627, green: 0.5921568627, blue: 0.4039215686, alpha: 1), color2: .black, bothBold: true)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        
        containerView.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        containerView.layer.cornerRadius = 20
        
    }
}
