//
//  CustomBox.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/17/21.
//

import Foundation
import UIKit
import ARKit
import RealityKit
import PencilKit
import Vision

class CustomBox: Entity, HasModel, HasAnchoring, HasCollision {
    
    required init(color: UIColor) {
        super.init()
        self.components[ModelComponent] = ModelComponent(
            mesh: .generateBox(size: 0.1),
            materials: [SimpleMaterial(
                color: color,
                isMetallic: false)
            ]
        )
    }
    
    convenience init(color: UIColor, position: SIMD3<Float>) {
        self.init(color: color)
        self.position = position
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
}
