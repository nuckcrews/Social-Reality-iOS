//
//  CreationCollectionViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/14/21.
//

import UIKit

class CreationCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var creations = [CreationModel]()
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        setupView()
        
    }
    
    func setupView() {
        
        for i in 0..<48 {
            creations.append(Testing.defaultCreations[i % 5])
        }
        
//        creations = Testing.defaultCreations
        
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
//            cell.configureCell(creation: creations[indexPath.row])
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

extension CreationCollectionViewController: UICollectionViewDelegateFlowLayout {
    
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: view.frame.width / 3, height: 120)
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }

        func collectionView(_ collectionView: UICollectionView, layout
            collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
    }
