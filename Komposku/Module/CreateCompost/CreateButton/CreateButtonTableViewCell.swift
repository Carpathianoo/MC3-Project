//
//  CreateButtonTableViewCell.swift
//  Komposku
//
//  Created by Ahmad Zaky on 29/07/21.
//

import UIKit

class CreateButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var addBahanButton: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var action: (() -> ())?
    
    func setupView() {
        addBahanButton.layer.cornerRadius = 10
        createDashPattern()
        containerView.onTap(action: {
            self.action?()
        })
    }
    
    func createDashPattern() {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: addBahanButton.bounds, cornerRadius: 8).cgPath
        layer.strokeColor = UIColor(red: 0.19, green: 0.59, blue: 0.40, alpha: 1).cgColor
        layer.fillColor = nil
        layer.lineWidth = 2
        layer.lineDashPattern = [8,6]
        containerView.layer.addSublayer(layer)
    }

    
}
