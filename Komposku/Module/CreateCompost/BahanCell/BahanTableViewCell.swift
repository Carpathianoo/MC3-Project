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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    var materials: MaterialModel? {
//        didSet {
//              setupView()
//        }
//    }

    func setupView(){
        viewContainer.layer.cornerRadius = 10
        viewContainer.backgroundColor = UIColor(named: "accentGray")
        viewContainer.layer.shadowColor = UIColor(red: 0.2, green: 0.31, blue: 0.22, alpha: 0.1).cgColor
        viewContainer.layer.shadowRadius = 10
        viewContainer.layer.shadowPath = UIBezierPath(rect: viewContainer.bounds).cgPath
        
    }
    
}
