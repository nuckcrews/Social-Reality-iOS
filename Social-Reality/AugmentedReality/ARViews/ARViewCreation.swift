//
//  ARViewCreation.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import UIKit
import RealityKit
import Vision
import PencilKit
import ARKit

//class ARViewCreation: ARView {
//
//    let coachingOverlay = ARCoachingOverlayView()
//
//    func setupView() {
//
//        let config = ARWorldTrackingConfiguration()
//        config.planeDetection = .horizontal
//        self.session.run(config, options: [])
//
//
//    }
//
//    func startCoaching() {
//        addCoaching()
//    }
//
//    func startRecording() {
//
//    }
//
//    func stopRecording() {
//
//    }
//
//}
//
//extension ARViewCreation: ARCoachingOverlayViewDelegate {
//
//    func addCoaching() {
//
//
//        coachingOverlay.delegate = self
//        coachingOverlay.session = self.session
//        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//        coachingOverlay.goal = .anyPlane
//
//        coachingOverlay.frame = self.frame
//        
//
//        coachingOverlay.activatesAutomatically = true
//
//        self.addSubview(coachingOverlay)
//    }
//
//    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
//        print("Coaching will activate")
//    }
//
//    func coachingOverlayViewDidRequestSessionReset(_ coachingOverlayView: ARCoachingOverlayView) {
//        print("Coaching did request")
//    }
//
//    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
//        //Ready to add entities next?
//        print("Coaching did deactivate")
//    }
//
//}
