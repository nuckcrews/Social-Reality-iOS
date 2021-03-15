//
//  AccountViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var datasource: Datasource!
    
    typealias Datasource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    enum Section: Hashable {
        case header
        case creations
    }
    
    enum Item: Hashable {
        case header(ProfileHeaderData) 
        case creation(CreationView)
    }
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.tag = TabbarItemTag.fifthViewConroller.rawValue
        
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        
        collectionView.register(ProfileCreationsHeaderView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProfileCreationsHeaderView")
        collectionView.register(creationViewCell.self, forCellWithReuseIdentifier: "creationViewCell")
        
        configureDatasource()
        
        getUser()
        
        // uploadImage()
    }
    
    func uploadImage() {
        Storage.upload.image(key: "defaultprofile", image: UIImage(named: "DefaultProfileImage")!) { (result) in
            Storage.download.imageURL(key: "defaultprofile") { (url) in
                print(url?.absoluteString)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print(user?.model?.image)
    }
    
    func getUser() {
        print(Auth().user)
        if let id = Auth().user?.userId {
            user = User(id: id, subscribe: false, completion: { (result) in
                print(result)
//                print(self.user?.model)
                self.user?.model?.last = "Crews"
                print(self.user?.model)
                self.user?.updateUser(item: self.user!.model!)
                print(self.user?.model)
            })
                //User(id: id, subscribe: false)
            
        }
    }
    
    
    @IBAction func tapSettings(_ sender: UIButton) {
        sender.jump()
        self.performSegue(withIdentifier: Segue.toSettingsfromProfile.rawValue, sender: nil)
    }
    
}
extension AccountViewController {
    
    private func cell(collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell {
        switch item {
        case .header(let data):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileHeaderCell", for: indexPath) as! profileHeaderCell
            cell.configure(with: data)
            
            return cell
        case .creation(let data):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "creationViewCell", for: indexPath) as! creationViewCell
            cell.configure(with: data.image)
            return cell
        }
    }
    
    private func configureDatasource() {
        datasource = Datasource(collectionView: collectionView, cellProvider: cell(collectionView:indexPath:item:))
        
        datasource.apply(snapshot(), animatingDifferences: false)
        datasource.supplementaryViewProvider = supplementary(collectionView:kind:indexPath:)
    }
    
    func snapshot() -> Snapshot {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.header, .creations])
        snapshot.appendItems([.header(ProfileHeaderData(name: "Nick", username: "ncrews", postCount: 26))], toSection: .header)
        snapshot.appendItems(CreationView.demoPhotos.map({ Item.creation($0) }), toSection: .creations)
        snapshot.appendItems(CreationView.demoPhotos2.map({ Item.creation($0) }), toSection: .creations)
        
        return snapshot
    }
    
}

extension AccountViewController {
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: sectionFor(index:environment:))
    }
    
    func createHeaderSection() -> NSCollectionLayoutSection {
        let headerItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        let headerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(280)), subitems: [headerItem])
        
        return NSCollectionLayoutSection(group: headerGroup)
    }
    
    func sectionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = datasource.snapshot().sectionIdentifiers[index]
        
        switch section {
        case .header:
            return createHeaderSection()
        case .creations:
            return createCreationsSection()
        }
    }
    
    func createCreationsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        
        //        section.orthogonalScrollingBehavior = .paging
        
        
        header.pinToVisibleBounds = true
        
        section.boundarySupplementaryItems = [header]
        
        
        return section
    }
    
    private func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProfileCreationsHeaderView", for: indexPath)
    }
    
}
