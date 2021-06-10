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
    
    // MARK: - View Instantiation
    
    internal static func instantiate() -> CreationCollectionViewController? {

        guard let viewController = Storyboard.CreationCollectionViewController.instantiate(CreationCollectionViewController.self) else {
            return nil
        }
        
        return viewController
    }
    
    // MARK: - Variables
    
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
        
        Query.remote.subscribe.creationsWithPredicate(field: Fields.creation.userID.rawValue, value: uid) { [weak self] models, lstn in
            
            guard let models = models else { return}
            
            self?.creations.removeAll()
            self?.creationModels.removeAll()
            
            for model in models {
                Query.cache.write.creation(model)
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
                Query.remote.update.creation(model.id, data: [Fields.creation.thumbnail.rawValue: res]) { result in
                    print(result)
                }

            }
        }
    }
    
    func toContentCollection() {
        
        DispatchQueue.main.async {
            
            if let viewController = CreationTableViewController.instantiate(creations: self.creationModels, selectedIndex: self.selectedIndex) {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreationViewCell.identifiers.creationViewCell.rawValue, for: indexPath) as? CreationViewCell {
            cell.configureCell(at: indexPath.row, creation: creations[indexPath.row])
            return cell
        } else {
            return CreationViewCell()
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
