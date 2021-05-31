//
//  UIView.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import Foundation
import UIKit

extension UIView {
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-15.0, 15.0, -12.0, 12.0, -8.0, 8.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func grow() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animation.duration = 1.5
        animation.values = [0.0, -80.0, 0.0, -60.0, 0.0, -40.0, 0.0, -20.0, 0.0, -10.0, 0.0]
        layer.add(animation, forKey: "grow")
    }
    
    func constraint(to view: UIView, attribute: NSLayoutConstraint.Attribute, secondAttribute: NSLayoutConstraint.Attribute,  inset: CGFloat = 0){
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = NSLayoutConstraint(item: self,
                                   attribute: attribute,
                                   relatedBy: .equal,
                                   toItem: view,
                                   attribute: secondAttribute,
                                   multiplier: 1,
                                   constant: inset)
        c.isActive = true
    }
    
    func constraint(_ anchor: NSLayoutDimension, constant: CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        anchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func pinEdges(to view: UIView, insets: UIEdgeInsets = .zero){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: self,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: view,
                                     attribute: .top,
                                     multiplier: 1,
                                     constant: insets.top)
        
        let bottom = NSLayoutConstraint(item: self,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .bottom,
                                        multiplier: 1,
                                        constant: insets.bottom)
        
        let leading = NSLayoutConstraint(item: self,
                                        attribute: .leading,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .leading,
                                        multiplier: 1,
                                        constant: insets.left)
        
        let trailing = NSLayoutConstraint(item: self,
                                        attribute: .trailing,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .trailing,
                                        multiplier: 1,
                                        constant: insets.right)
        top.isActive = true
        bottom.isActive = true
        leading.isActive = true
        trailing.isActive = true
    }
    
}
