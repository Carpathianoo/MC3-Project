//
//  BahanTableViewCell.swift
//  Komposku
//
//  Created by Ahmad Zaky on 28/07/21.
//

import UIKit

class BahanTableViewCell: UITableViewCell {

    @IBOutlet weak var bahanTitle: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var bahanAmount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var materials: MaterialDetail? {
        didSet {
            guard let material = materials else {
                return
            }

            bahanTitle.text = material.name
            bahanAmount.text = "\(material.quantity) bagian"
        }
    }

    func setupView(){
        viewContainer.dropShadowCell()
        viewContainer.layer.cornerRadius = 10
        let font = UIFont.systemFont(ofSize: 17)
        bahanTitle.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        bahanTitle.adjustsFontForContentSizeCategory = true
        bahanAmount.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        bahanAmount.adjustsFontForContentSizeCategory = true
    }
    
}
