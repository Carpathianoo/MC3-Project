//
//  LineProcessView.swift
//  Komposku
//
//  Created by Clara Anggraini on 29/07/21.
//

import UIKit

class LineProcessView: UIView {

    let containerView = UIView()
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         setup()
     }
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         setup()
     }

     private func setup() {
        self.frame = CGRect(x: 0, y: 0, width: 320, height: 22)
         let shapeLayer = CAShapeLayer()
         shapeLayer.strokeColor = UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1).cgColor
         shapeLayer.lineWidth = 2
        let start = CGPoint(x: 11, y: layer.bounds.minY-1)
         let end = CGPoint(x: 11, y: layer.bounds.maxY-4)
         let path = CGMutablePath()
         path.addLines(between: [start, end])
         shapeLayer.path = path
         self.layer.addSublayer(shapeLayer)
     }

}
