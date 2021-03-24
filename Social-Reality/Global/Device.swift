//
//  Device.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/24/21.
//

import Foundation
import RealityKit
import ARKit

struct Device {

    static var compatible: Bool = {
        return ARGeoTrackingConfiguration.isSupported
    }()
    
}
