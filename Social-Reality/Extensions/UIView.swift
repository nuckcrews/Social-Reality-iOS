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
    
}
