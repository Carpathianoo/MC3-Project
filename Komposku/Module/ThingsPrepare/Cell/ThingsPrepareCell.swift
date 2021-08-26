//
//  ThingsPrepareCell.swift
//  Komposku
//
//  Created by Ahmad Zaky on 20/08/21.
//

import UIKit

class ThingsPrepareCell: UICollectionViewCell {

    @IBOutlet weak var prepareTitle: UILabel!
    @IBOutlet weak var prepareImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UISetup()
    }
    
    func dataSetup(_ data: ThingsPrepare){
        prepareTitle.text = data.title
        prepareImage.image = UIImage(named: data.image ?? "")
    }
    
    func UISetup(){
        let font = UIFont.systemFont(ofSize: 20)
        prepareTitle.font = UIFontMetrics(forTextStyle: .title3).scaledFont(for: font)
        prepareTitle.adjustsFontForContentSizeCategory = true
    }
    

}
