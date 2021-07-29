//
//  TotalItemTableViewCell.swift
//  Komposku
//
//  Created by Ahmad Zaky on 29/07/21.
//

import UIKit

class TotalItemTableViewCell: UITableViewCell {

    @IBOutlet weak var amountItem: UILabel!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setupView() {
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = UIColor(red: 0.84, green: 0.909, blue: 0.878, alpha: 1)
    }
    
}
