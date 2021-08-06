//
//  UIView+Ext.swift
//  Komposku
//
//  Created by Fernando Lawrence on 02/08/21.
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
