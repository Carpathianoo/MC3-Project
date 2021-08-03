//
//  MoistureLabel.swift
//  Komposku
//
//  Created by Clara Anggraini on 29/07/21.
//

import UIKit

class MoistureLabel: UILabel {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor(red: 124/255, green: 204/255, blue: 167/255, alpha: 1.0)
        layer.cornerRadius = frame.width/2
        layer.masksToBounds = true
    
    }
    
}
