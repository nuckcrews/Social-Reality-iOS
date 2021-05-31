//
//  CustomImageViews.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import UIKit

class CircleImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

class CorneredImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = cornerRadius
        
    }
    
}
