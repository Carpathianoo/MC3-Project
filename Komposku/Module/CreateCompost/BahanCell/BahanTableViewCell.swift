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
        }
    }

    func setupView(){
        
        viewContainer.layer.cornerRadius = 10
        viewContainer.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        viewContainer.layer.shadowColor = UIColor(red: 0.2, green: 0.31, blue: 0.22, alpha: 0.1).cgColor
        viewContainer.layer.shadowRadius = 10
        viewContainer.layer.shadowPath = UIBezierPath(rect: viewContainer.bounds).cgPath
        
    }
    
}
