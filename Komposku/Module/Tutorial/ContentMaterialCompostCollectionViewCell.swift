//
//  ContentMaterialCompostCollectionViewCell.swift
//  Komposku
//
//  Created by Fernando Lawrence on 28/07/21.
//

import UIKit

class ContentMaterialCompostCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageContentMaterial: UIImageView!
    @IBOutlet weak var labelContentMaterial: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageContentMaterial.layer.cornerRadius = 10
        imageContentMaterial.accessibilityIgnoresInvertColors = true
        
        let customFont = FontGuide()
        labelContentMaterial.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont.labelContainMaterial)
        labelContentMaterial.adjustsFontForContentSizeCategory = true
    }

}
