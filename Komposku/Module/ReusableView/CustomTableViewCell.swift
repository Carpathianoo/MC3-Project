//
//  TableViewCell.swift
//  Komposku
//
//  Created by Clara Anggraini on 30/07/21.
//

import UIKit

class CustomTableViewCell: UIView {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 10
        layer.masksToBounds = false
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
    }

}
