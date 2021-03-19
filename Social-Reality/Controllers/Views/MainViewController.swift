//
//  MainViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit
import RealityKit
import ARKit
import Firebase

class MainViewController: UIViewController {

    @IBOutlet weak var arView: ARView!
    
    private var readyForReality = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.tag = TabBarItemTag.firstViewController.rawValue
        
        CoverToMainDelegate? = self
        
//        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        
//        if readyForReality {
//            setupARView()
//        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if readyForReality {
            pauseARView()
        }
    }
    
    // MARK: Setup Methods
    
    func setupARView() {
        arView.session.delegate = self
        arView.automaticallyConfigureSession = false
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
    }
    
    func pauseARView() {
        arView.session.pause()
    }
    
    // MARK: Object Placement
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: arView)
        let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        if let firstResult = results.first {
            let anchor = ARAnchor(name: "toy_robot_vintage", transform: firstResult.worldTransform)
            arView.session.add(anchor: anchor)
        } else {
            print("No surface found")
        }
    }
    
    func placeObject(named entityName: String, for anchor: ARAnchor) {
        do {
            let entity = try ModelEntity.loadModel(named: entityName)
            
            entity.generateCollisionShapes(recursive: true)
            arView.installGestures([.rotation, .translation], for: entity)
            
            let anchorEntity = AnchorEntity(anchor: anchor)
            anchorEntity.addChild(entity)
            arView.scene.addAnchor(anchorEntity)
            
        } catch {
            print("No entity")
        }
    }
    
    
    // MARK: Creation Interaction
    
    @IBAction func tapLike(_ sender: UIButton) {
        sender.jump()
    }
    
    @IBAction func tapComment(_ sender: UIButton) {
        sender.jump()
    }
    
    @IBAction func tapShare(_ sender: UIButton) {
        sender.jump()
    }
    
}

extension MainViewController: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchorName = anchor.name, anchorName == "toy_robot_vintage" {
                placeObject(named: anchorName, for: anchor)
            }
        }
    }
}
extension MainViewController: CoverToMainProtocolDelegate {
    func readyForSession() {
        readyForReality = true
        setupARView()
    }
}
