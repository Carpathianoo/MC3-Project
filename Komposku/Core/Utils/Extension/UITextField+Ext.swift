//
//  UITextField+Ext.swift
//  Komposku
//
//  Created by Ahmad Zaky on 30/07/21.
//

import Foundation
import UIKit

extension UITextField {
    func addUnderline() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.bounds.height + 3, width: self.bounds.width, height: 1.5)
        bottomLine.backgroundColor = UIColor.black.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
}
