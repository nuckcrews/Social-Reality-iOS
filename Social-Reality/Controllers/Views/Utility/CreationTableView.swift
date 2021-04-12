//
//  CreationCollectionView.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/29/21.
//

import UIKit

class CreationTableView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    var creations = [CreationModel]()
    var user: UserModel?
    
    private var setup = false
    private var currentIndex = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !setup {
            setupView()
            setup = true
        }
        
    }
    
    func setIndex(_ index: Int) {
        
        tableView.alpha = 1
        
        tableView.contentInsetAdjustmentBehavior = .never
        
//        tableView.contentOffset.y = (frame.height * CGFloat(index)) // - Device.topSafeAreaHeight
        
        tableView.scrollToRow(at: IndexPath(item: index, section: 0), at: .top, animated: false)
        
//        if let cell = tableView.cellForRow(at: IndexPath(item: index, section: 0)) as? creationVideoCell {
//            cell.presented()
//        }
    
    }
    
    func setupView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        let cellSize = CGSize(width: frame.width, height: frame.height)
        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical //.horizontal
//        layout.itemSize = cellSize
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.minimumLineSpacing = 0.0
//        layout.minimumInteritemSpacing = 0.0
//        collectionView.contentInsetAdjustmentBehavior = .never
//        collectionView.setCollectionViewLayout(layout, animated: false)
//        print("adjusted")
        
        tableView.reloadData()
        
    }
    
    func reloadCollection() {
        setupView()
        
    }
    
    func findWord(sentence: String, word: String) -> Int {
        
        let r = sentence.range(of: word)
        
        guard let lower = r?.lowerBound else { return 0 }
        
        return sentence.distance(from: sentence.startIndex, to: lower)
        
    }
    
    func changedIndex(_ index: Int) {
        
        for i in 0..<creations.count {
            if let cell = tableView.cellForRow(at: IndexPath(item: i, section: 0)) as? creationVideoCell {
                i != index ? cell.dismissed() : cell.presented()
            }
        }
        
    }
    
}

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

extension CreationTableView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.creationVideoCell.rawValue, for: indexPath) as? creationVideoCell {
            cell.configureCell(creations[indexPath.row], user)
            if indexPath.row == currentIndex {
                cell.presented()
            }
            return cell
        } else {
            return creationVideoCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.frame.height
    }
    
    
}
