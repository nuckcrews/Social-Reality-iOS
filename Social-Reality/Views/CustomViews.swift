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

class ShadowViewCornered: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    private var shadowLayer: ShadowLayer!
    private var fillColor: UIColor = .white
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

class ShadowViewRoundedVertical: UIView {
    
    private var shadowLayer: ShadowLayer!
    private var fillColor: UIColor = .white
    private var cornerRadius: CGFloat = 12.0
    private var opacity: Float = 0.2
    private var shadowRadius: CGFloat = 5
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cornerRadius = frame.width / 2
        
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

class ShadowViewRoundedHorizontal: UIView {
    
    private var shadowLayer: ShadowLayer!
    private var fillColor: UIColor = .white
    private var cornerRadius: CGFloat = 0.0
    private var opacity: Float = 0.2
    private var shadowRadius: CGFloat = 5
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cornerRadius = frame.height / 2
        
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

class ShadowViewCircle: UIView {
    
    private var shadowLayer: ShadowLayer!
    private var fillColor: UIColor = .white
    private var cornerRadius: CGFloat = 0.0
    private var opacity: Float = 0.2
    private var shadowRadius: CGFloat = 5
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cornerRadius = frame.height / 2
        
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
    @IBInspectable var cornerRadius: CGFloat = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        
    }
    
}

class RoundViewVertical: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
        
    }
    
}

class RoundViewHorizontal: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
        
    }
    
}


class CorneredView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = cornerRadius
        
    }
    
}

class CircleView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
        
    }
    
}
