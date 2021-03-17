//
//  PencilView.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/17/21.
//

import Foundation
import ARKit
import RealityKit
import Vision
import PencilKit

class PencilView: PKCanvasView {
    
    func setupView(color: UIColor) {
        
        self.tool = PKInkingTool(.marker, color: color, width: 40)
        
    }
    
}
