//
//  CreationCollectionViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/14/21.
//

import UIKit
import XLPagerTabStrip

// MARK: - Creation Collection View Controller

class CreationCollectionViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var creations = [CreationThumbNailView]()
    var creationModels = [CreationModel]()
    var selectedIndex = 0
    var pageIndex: Int = 0
    var pageTitle: String?
    var segmentImage: UIImage?

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupView()
        
    }
    
    // MARK: - View Setup
    
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
        
        fetchCreations()
        
    }
    
    // MARK: - Fetch Creations
    
    func fetchCreations() {
        
        guard let uid = Auth0.uid else {
            collectionView.reloadData()
            return
        }
        
        Query.subscribe.creationsWithPredicate(field: Fields.creation.userID.rawValue, value: uid) { [weak self] models, lstn in
            
            guard let models = models else { return}
            
            self?.creations.removeAll()
            self?.creationModels.removeAll()
            
            for model in models {
                self?.creations.append(CreationThumbNailView(model: model))
                self?.creationModels.append(model)
            }
            
            self?.collectionView.reloadData()
        }
        
    }
    
    // MARK: - Testing Methods
    
    var added = false
    func addThumbnail(model: CreationModel) {
        guard !added else {
            return
        }
        
        Video0.getThumbnailImage(forUrl: model.videoURL) { img in
            guard let img = img else { return }
            Storage0.remote.upload.thumbnailImage(key: model.id, image: img) { res in
                guard let res = res else { return }
                Query.update.creation(id: model.id, data: [Fields.creation.thumbnail.rawValue: res]) { result in
                    print(result)
                }

            }
        }
    }
    
    func toContentCollection() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier:  Segue.toCreationTableFromProfile.rawValue, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CreationTableViewController {
            dest.creations = creationModels
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
