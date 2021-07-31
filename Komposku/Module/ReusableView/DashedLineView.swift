//
//  DashedLineView.swift
//  Komposku
//
//  Created by Clara Anggraini on 29/07/21.
//

import UIKit

class DashedLineView: UIView {

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
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(red: 49/255, green: 151/255, blue: 103/255, alpha: 0.2).cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.lineDashPattern = [10, 3]
        let start = CGPoint(x: layer.bounds.minX, y: layer.bounds.maxY/2)
        let end = CGPoint(x: layer.bounds.maxX, y: layer.bounds.maxY/2)
        let path = CGMutablePath()
        path.addLines(between: [start, end])
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
}
