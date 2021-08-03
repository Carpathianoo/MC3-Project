//
//  StringModifier.swift
//  Komposku
//
//  Created by Ahmad Zaky on 03/08/21.
//

import Foundation
import UIKit

class StringModifier {
    
    static func modifyDetailMaterial(sentence: [String], color1: UIColor, color2: UIColor, bothBold: Bool) -> NSMutableAttributedString {
        let string = NSMutableAttributedString(string: "")
        if bothBold {
            let firstAttributes = [NSAttributedString.Key.foregroundColor: color1, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
            let secondAttributes = [NSAttributedString.Key.foregroundColor: color2, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
            for i in 0..<sentence.count {
                if i % 2 == 0 {
                    let strings = NSAttributedString(string: sentence[i], attributes: firstAttributes)
                    string.append(strings)
                } else {
                    let strings = NSAttributedString(string: sentence[i], attributes: secondAttributes)
                    string.append(strings)
                }
            }
        } else {
            let firstAttributes = [NSAttributedString.Key.foregroundColor: color1, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
            let secondAttributes = [NSAttributedString.Key.foregroundColor: color2, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
            for i in 0..<sentence.count {
                if i % 2 == 0 {
                    let strings = NSAttributedString(string: sentence[i], attributes: firstAttributes)
                    string.append(strings)
                } else {
                    let strings = NSAttributedString(string: sentence[i], attributes: secondAttributes)
                    string.append(strings)
                }
            }
        }
        return string
    }
    
}
