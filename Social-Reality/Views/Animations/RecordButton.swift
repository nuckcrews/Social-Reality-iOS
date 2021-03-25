//
//  RecordButton.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/24/21.
//

import UIKit

class RecordButton: UIView {
    
    var circleLayer: CAShapeLayer?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor.primary.cgColor
        layer.borderWidth = 3
        
        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2),
            radius: (frame.size.width - 6) / 2,
            startAngle: CGFloat(-Double.pi / 2),
            endAngle: CGFloat(Double.pi + (Double.pi / 2)),
            clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer?.path = circlePath.cgPath
        circleLayer?.fillColor = UIColor.clear.cgColor
        circleLayer?.strokeColor = UIColor.primary.cgColor
        circleLayer?.lineWidth = 6.0
        
        // Don't draw the circle initially
        circleLayer?.strokeEnd = 0.0
        
        // Add the circleLayer to the view's layer's sublayers
        guard let circle = circleLayer else { return }
        layer.addSublayer(circle)
        
    }
    
    func animateCircle(duration: TimeInterval) {
        // We want to animate the strokeEnd property of the circleLayer
        
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.layer.borderColor = UIColor(named: "Tinted")?.cgColor
            self.layer.borderWidth = 6
        }

        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration

        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1

        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: .linear)

        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer?.strokeEnd = 1.0

        // Do the actual animation
        circleLayer?.add(animation, forKey: "animateCircle")
    
    }
    
    func stopAnimating() {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.layer.borderColor = UIColor.primary.cgColor
            self.layer.borderWidth = 3
        }

        circleLayer?.removeFromSuperlayer()
        circleLayer?.removeAllAnimations()
    }
    
    func tapButton() {
        
    }
    
    func holdButton() {
        
    }
    
}
