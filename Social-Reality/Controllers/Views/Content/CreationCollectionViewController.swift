//
//  CreationCollectionViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/30/21.
//

import UIKit

class CreationCollectionViewController: UIViewController {

    @IBOutlet weak var creationCollectionView: CreationCollectionView!
    
    var user: User?
    var creations = [CreationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUser()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        getCreations()
    }
    
    func getUser() {
        
        guard let uid = Auth0.uid else { return }
    
        Query.get.user(id: uid) { [weak self] model in
            guard let model = model else { return }
            self?.user = User(model: model)
        }
        
    }
    
    func getCreations() {
        
        guard let model = Testing.defaultCreation.model else {
            return
        }
        for _ in 0..<4 {
            creations.append(model)
        }
        
        creationCollectionView.creations = creations
        creationCollectionView.reloadCollection()
        
    }


}
