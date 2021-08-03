//
//  UIView+Ext.swift
//  Komposku
//
//  Created by Ahmad Zaky on 29/07/21.
//

import Foundation
import UIKit

public extension UIView {
    private typealias Action = (() -> Void)?
    private struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "UIView_tapGesture"
    }
    
    private var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedObjectKeys.tapGestureRecognizer,
                    newValue,
                    objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
                )
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(
                self,
                &AssociatedObjectKeys.tapGestureRecognizer
            ) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    func onTap(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        }
    }
    
    func dropShadowCell() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 2, height: 20)
        self.layer.shadowRadius = 4
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor){
           clipsToBounds = true
           let gradientLayer = CAGradientLayer()
           gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
           gradientLayer.frame = self.bounds
           gradientLayer.startPoint = CGPoint(x: 0, y: 0)
           gradientLayer.endPoint = CGPoint(x: 0, y: 1)
           print(gradientLayer.frame)
           self.layer.insertSublayer(gradientLayer, at: 0)
       }
}
