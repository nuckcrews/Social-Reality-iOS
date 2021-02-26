//
//  MainViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit
import Amplify
import AmplifyPlugins

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.tag = TabbarItemTag.firstViewController.rawValue

    }
    
}

