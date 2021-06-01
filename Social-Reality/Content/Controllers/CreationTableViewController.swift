//
//  CreationTableViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/30/21.
//

import UIKit

// MARK: - Creation Table View Controller

class CreationTableViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var creationTableView: CreationTableView!
    @IBOutlet weak var volumeIndicatorButton: UIButton!
    
    // MARK: - Variables
    
    var user: UserModel?
    var creations = [CreationModel]()
    var startIndex: Int = 0
    var indexSet = false
    
    // MARK: - View Lifecycle
    
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
    
    // MARK: - User Fetching
    
    func getUser() {
        
        guard let uid = Auth0.uid else { return }
        
        user = Query.defaults.get.user(uid)
        
        Query.get.user(uid) { [weak self] model in
            guard let model = model else { return }
            if self?.user != model {
                Query.defaults.write.user(model)
                self?.user = model
            }
            
        }
        
    }
    
    // MARK: - Creation Fetching
    
    func getCreations() {
        
        if creations.isEmpty {
            creationTableView.creations = Testing.defaultCreations
        } else {
            creationTableView.creations = creations
        }

        creationTableView.reloadCollection()
        
    }
    
    // MARK: - Action Outlets
    
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
