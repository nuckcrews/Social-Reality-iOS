//
//  CreationCollectionView.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/29/21.
//

import UIKit

// MARK: - Creation TableView Utility

class CreationTableView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    var creations = [CreationModel]()
    var user: UserModel?
    
    private var setup = false
    private var currentIndex = 0
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !setup {
            setupView()
            setup = true
        }
        
    }
    
    // MARK: - View Setup
    
    func setIndex(_ index: Int) {
        
        tableView.alpha = 1
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.scrollToRow(at: IndexPath(item: index, section: 0), at: .top, animated: false)
        
        
    }
    
    func setupView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.reloadData()
        
    }
    
    func reloadCollection() {
        setupView()
        
    }
    
    // MARK: - Creation Handling
    
    func playCreation() {
        if let cell = tableView.cellForRow(at: IndexPath(item: currentIndex, section: 0)) as? CreationVideoCell {
            cell.creationAVPlayerView.playCreation()
        }
    }
    
    func pauseCreation() {
        if let cell = tableView.cellForRow(at: IndexPath(item: currentIndex, section: 0)) as? CreationVideoCell {
            cell.creationAVPlayerView.pauseCreation()
        }
    }
    
    // MARK: - Index Handling
    
    func changedIndex(_ index: Int) {
        
        for i in 0..<creations.count {
            if let cell = tableView.cellForRow(at: IndexPath(item: i, section: 0)) as? CreationVideoCell {
                i != index ? cell.dismissed() : cell.presented()
            }
        }
        
    }
    
}

// MARK: - ScrollView Delegate

extension CreationTableView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let index = Int(round(scrollView.contentOffset.y / frame.height))
        if index != currentIndex {
            print("changing index", index)
            changedIndex(index)
            currentIndex = index
        }
        
    }
    
}

// MARK: - TableView Delegate

extension CreationTableView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CreationVideoCell.identifiers.creationVideoCell.rawValue, for: indexPath) as? CreationVideoCell {
            cell.configureCell(creations[indexPath.row], user)
            if indexPath.row == currentIndex {
                cell.presented()
            }
            return cell
        } else {
            return CreationVideoCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.frame.height
    }
    
}
