//
//  CLLocationManager.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/15/21.
//

import Foundation
import CoreLocation

// MARK: Location Manager Utility Methods

extension CLLocationManager {
    
    var authorizationStatus: Bool {
        guard CLLocationManager.locationServicesEnabled() else {
            return false
        }
        switch CLLocationManager.authorizationStatus() {
        case .restricted, .denied, .notDetermined:
            return false
        case .authorizedWhenInUse, .authorizedAlways:
            return true
        @unknown default:
            return false
        }
    }
    
}
