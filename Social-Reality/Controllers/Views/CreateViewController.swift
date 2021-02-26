//
//  ViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit
import RealityKit
import Amplify
import AmplifyPlugins

class CreateViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.tag = TabbarItemTag.thirdViewConroller.rawValue
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
    }
    
    
    
    func tryFunc() {

    }
}
