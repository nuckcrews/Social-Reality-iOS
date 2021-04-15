//
//  Device.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/24/21.
//

import Foundation
import UIKit
import RealityKit
import ARKit

struct Device {

    static var compatible: Bool = {
        return ARGeoTrackingConfiguration.isSupported
    }()
    
    static var isMuted: Bool = false {
        didSet {
            
            mainVolumeDelegate?.changeVolume()
            
        }
    }
    
    static var topSafeAreaHeight: CGFloat {
        let window = UIApplication.shared.windows[0]
        let safeFrame = window.safeAreaLayoutGuide.layoutFrame
        return safeFrame.minY
    }
    
    static var bottomSafeAreaHeight: CGFloat {
        let window = UIApplication.shared.windows[0]
        let safeFrame = window.safeAreaLayoutGuide.layoutFrame
        return window.frame.maxY - safeFrame.maxY
    }
    
}
