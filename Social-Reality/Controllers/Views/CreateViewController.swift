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

// MARK: Content Creation View Controller

class CreateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.tag = TabBarItemTag.thirdViewController.rawValue

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }

    
}
