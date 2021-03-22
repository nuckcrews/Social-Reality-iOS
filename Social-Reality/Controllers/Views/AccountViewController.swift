//
//  AccountViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var usernameTitleButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var followers = [String]()
    var following = [String]()
    var likes = [String]()
    
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
        
        tabBarItem.tag = TabBarItemTag.fifthViewController.rawValue
        
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        collectionView.register(ProfileCreationsHeaderView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Cells.ProfileCreationsHeaderView.rawValue)
        
        configureDatasource()
        
        getUser()
        
    }
    
    func getUser() {
        
        guard let id = Auth0.uid else {
            self.populateViews()
            return
        }
        
        user = User(id: id)
        
        user?.subscribeModel(completion: { res in
            if res != nil {
                self.populateViews()
            }
        })
        
    }
    
    func populateViews() {
        
        reloadDataSource()
        
        guard let model = user?.model else { return }
        
        usernameTitleButton.setTitle(model.username, for: .normal)
        
    }
    
    func toEditProfile() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toEditProfileFromAccount.rawValue, sender: nil)
        }
    }
    
    func toSettings() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toSettingsFromProfile.rawValue, sender: nil)
        }
    }
    
    func toContentDetail() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toCreationDetailFromAccount.rawValue, sender: nil)
        }
    }
    
    @IBAction func tapSettings(_ sender: UIButton) {
        
        sender.jump()
        toSettings()
        
    }
    
    @IBAction func tapEditProfile(_ sender: UIButton) {
        
        sender.jump()
        toEditProfile()
        
    }
    
}

extension AccountViewController: UICollectionViewDelegate {
    
    private func cell(collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell {
        
        switch item {
        case .header(let data):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.profileHeaderCell.rawValue, for: indexPath) as? profileHeaderCell {
                cell.configure(with: data)
                return cell
            } else {
                return profileHeaderCell()
            }
        case .creation(let data):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.creationViewCell.rawValue, for: indexPath) as? creationViewCell {
                cell.configure(with: data.image)
                return cell
            } else {
                return creationViewCell()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.toContentDetail()
    }
    
    private func configureDatasource() {
        
        datasource = Datasource(collectionView: collectionView, cellProvider: cell(collectionView:indexPath:item:))
        datasource.apply(snapshot(), animatingDifferences: false)
        datasource.supplementaryViewProvider = supplementary(collectionView:kind:indexPath:)
        
    }
    
    private func reloadDataSource() {
        guard datasource != nil else { return }
        datasource.apply(snapshot(), animatingDifferences: false)
    }
    
    func snapshot() -> Snapshot {
        
        var snapshot = Snapshot()
        
        let profileData = ProfileHeaderData(
            image: user?.model?.image ?? ProfileImage.defaultURL,
            first: user?.model?.first ?? "Your",
            last: user?.model?.last ?? "Name",
            username: user?.model?.username ?? "username",
            followerCount: followers.count,
            followingCount: following.count,
            likesCount: likes.count)
        
        snapshot.appendSections([.header, .creations])
        snapshot.appendItems([.header(profileData)], toSection: .header)
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
        let headerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300)), subitems: [headerItem])
        
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
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        header.pinToVisibleBounds = true
        
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }
    
    private func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Cells.ProfileCreationsHeaderView.rawValue, for: indexPath)
    }
    
}
