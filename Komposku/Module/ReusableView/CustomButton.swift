//
//  CustomButton.swift
//  Komposku
//
//  Created by Clara Anggraini on 29/07/21.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        self.frame = CGRect(x: 0, y: 0, width: 375, height: 30)
        self.layer.backgroundColor = UIColor(red: 49/255, green: 151/255, blue: 103/255, alpha: 1.0).cgColor
        self.layer.cornerRadius = 10
        self.tintColor = UIColor.white
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }

}
