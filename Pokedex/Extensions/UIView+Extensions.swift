//
//  UIView+Extensions.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

extension UIView {
    
    func changeBackgroundColor(_ typeSlot: slotColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = typeSlot.backgoundColor
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = frame
        layer.addSublayer(gradientLayer)
    }
    
}
