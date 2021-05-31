//
//  CustomShadows.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import Foundation
import UIKit

class ShadowLayer: CAShapeLayer {
    
    init(viewBounds: CGRect, fillColor: UIColor, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat) {
        super.init()
        self.path = UIBezierPath(roundedRect: viewBounds, cornerRadius: cornerRadius).cgPath
        self.fillColor = fillColor.cgColor
        self.shadowOpacity = opacity
        self.shadowRadius = shadowRadius
        self.shadowColor = UIColor.black.cgColor
        self.shadowPath = self.path
        self.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
