//
//  CreationCollectionViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/30/21.
//

import UIKit

class CreationTableViewController: UIViewController {

    @IBOutlet weak var creationTableView: CreationTableView!
    @IBOutlet weak var volumeIndicatorButton: UIButton!
    
    var user: User?
    var creations = [CreationModel]()
    var startIndex: Int = 0
    var indexSet = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Device.isMuted ?
            volumeIndicatorButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal) :
            volumeIndicatorButton.setImage(UIImage(systemName: "speaker.wave.2"), for: .normal)
        
        getUser()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if !indexSet {
            creationTableView.tableView.alpha = 0
            getCreations()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
//        getCreations()
        if !indexSet {
            creationTableView.setIndex(startIndex)
            indexSet = true
        } else {
            creationTableView.playCreation()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        creationTableView.pauseCreation()
        
    }
    
    func getUser() {
        
        guard let uid = Auth0.uid else { return }
    
        Query.get.user(id: uid) { [weak self] model in
            guard let model = model else { return }
            self?.user = User(model: model)
        }
        
    }
    
    func getCreations() {
        
        creationTableView.creations = Testing.defaultCreations
        creationTableView.reloadCollection()
        
        
    }
    
    @IBAction func tapVolume(_ sender: UIButton) {
        
        sender.jump()
        
        Device.isMuted = !Device.isMuted
        
        Device.isMuted ?
            volumeIndicatorButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal) :
            volumeIndicatorButton.setImage(UIImage(systemName: "speaker.wave.2"), for: .normal)
        
        
    }
    
    @IBAction func tapBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }


}
