//
//  CustomViews.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/27/21.
//

import Foundation
import UIKit

class ShadowViewBox: UIView {
    
    private var shadowLayer: ShadowLayer!
    private var fillColor: UIColor = .white
    private var cornerRadius: CGFloat = 0.0
    private var opacity: Float = 0.2
    private var shadowRadius: CGFloat = 5
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.backgroundColor != nil {
            fillColor = self.backgroundColor!
            self.backgroundColor = nil
        }
        
        if shadowLayer == nil {
            shadowLayer = ShadowLayer(
                viewBounds: bounds,
                fillColor: fillColor,
                opacity: opacity,
                shadowRadius: shadowRadius,
                cornerRadius: cornerRadius)
            layer.insertSublayer(shadowLayer, at: 0)
        } else {
            shadowLayer?.removeFromSuperlayer()
            shadowLayer = nil
            shadowLayer = ShadowLayer(
                viewBounds: bounds,
                fillColor: fillColor,
                opacity: opacity,
                shadowRadius: shadowRadius,
                cornerRadius: cornerRadius)
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard UIApplication.shared.applicationState == .inactive else { return }
        self.layoutSubviews()
    }
    
}

class BorderedView: UIView {
    
    @IBInspectable var borderColor: UIColor = .clear
    @IBInspectable var borderWidth: CGFloat = 1
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        
    }
    
}
