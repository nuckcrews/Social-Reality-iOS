//
//  TestViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/1/21.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View Instantiation
    
    internal static func instantiate() -> TestViewController? {

        guard let viewController = Storyboard.TestViewController.instantiate(TestViewController.self) else {
            return nil
        }
        
        return viewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    
}



