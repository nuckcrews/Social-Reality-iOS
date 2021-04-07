//
//  CreationCollectionView.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/29/21.
//

import UIKit

class CreationCollectionView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    
    func setupView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let cellSize = CGSize(width: frame.width, height: frame.height)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.setCollectionViewLayout(layout, animated: false)
        print("adjusted")
        
    }
    
    func reloadCollection() {
        setupView()
        collectionView.reloadData()
    }
    
    func findWord(sentence: String, word: String) -> Int {
        
        let r = sentence.range(of: word)
        
        guard let lower = r?.lowerBound else { return 0 }
        
        return sentence.distance(from: sentence.startIndex, to: lower)
        
    }
    
    func changedIndex(_ index: Int) {
        
        for i in 0..<creations.count {
            if let cell = collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as? creationVideoCell {
                i != index ? cell.dismissed() : cell.presented()
            }
        }
        
    }
    
}

extension CreationCollectionView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let index = Int(round(scrollView.contentOffset.y / frame.height))
        if index != currentIndex {
            print("changing index", index)
            changedIndex(index)
            currentIndex = index
        }
        
    }
    
}

extension CreationCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return creations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.creationVideoCell.rawValue, for: indexPath) as? creationVideoCell {
            cell.configureCell(creations[indexPath.row], user)
            if indexPath.row == currentIndex {
                cell.presented()
            }
            return cell
        } else {
            return creationVideoCell()
        }
    }
    
}
