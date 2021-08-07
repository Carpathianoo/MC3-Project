//
//  StringModifierTutorial.swift
//  Komposku
//
//  Created by Fernando Lawrence on 06/08/21.
//

import Foundation
import UIKit

class StringModifierTutorial {
    
    static func modifyDetailMaterial(sentence: [String], color1: UIColor, color2: UIColor, bothBold: Bool) -> NSMutableAttributedString {
        let string = NSMutableAttributedString(string: "")
        if bothBold {
            let firstAttributes = [NSAttributedString.Key.foregroundColor: color1, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
            let secondAttributes = [NSAttributedString.Key.foregroundColor: color2, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        } else {
            let firstAttributes = [NSAttributedString.Key.foregroundColor: color1, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
            let secondAttributes = [NSAttributedString.Key.foregroundColor: color2, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        }
        return string
    }
    
}
