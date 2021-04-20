//
//  CreationCollectionViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/14/21.
//

import UIKit
import XLPagerTabStrip

class CreationCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var creations = [CreationThumbNailView]()
    
    var selectedIndex = 0
    var pageIndex: Int = 0
    var pageTitle: String?
    var segmentImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupView()
        
    }
    
    func setLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = .zero
        layout.itemSize = CGSize(width: view.frame.width / 3, height: view.frame.width * 5 / 12)
        collectionView.collectionViewLayout = layout
    }
    
    func setupView() {

        setLayout()
        
        for i in Testing.defaultCreations {
            creations.append(CreationThumbNailView(model: i))
        }
        
        
        collectionView.reloadData()
        
    }
    
    func toContentCollection() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier:  Segue.toCreationTableFromProfile.rawValue, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CreationTableViewController {
            dest.startIndex = selectedIndex
        }
    }
    
    
}

extension CreationCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return creations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.creationViewCell.rawValue, for: indexPath) as? creationViewCell {
            cell.configureCell(creation: creations[indexPath.row])
            return cell
        } else {
            return creationViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        toContentCollection()
    }
    
}


extension CreationCollectionViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(image: segmentImage?.withTintColor(.grayText), highlightedImage: segmentImage?.withTintColor(.mainText), userInfo: nil)
    }
}
