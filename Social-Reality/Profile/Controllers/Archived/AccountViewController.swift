//
//  AccountViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit

// MARK: - Inbox View Controller -> Archived

class AccountViewController: UIViewController {
    
    @IBOutlet weak var usernameTitleButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var followers = [String]()
    var following = [String]()
    var likes = [String]()
    
    private var datasource: Datasource!
    var configured = false
    
    typealias Datasource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    enum Section: Hashable {
        case header
        case creations
    }
    
    enum Item: Hashable {
        case header(ProfileHeaderData)
        case creation(CreationThumbNailView)
    }
    
    var user: User?
    var selectedIndex = 0
    
    // MARK: - View Instantiation
    
    internal static func instantiate() -> AccountViewController? {

        guard let viewController = Storyboard.Main.instantiate(AccountViewController.self) else {
            return nil
        }
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.tag = TabBarItemTag.fifthViewController.rawValue
        
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        collectionView.register(ProfileCreationsHeaderView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileCreationsHeaderView.identifiers.profileCreationsHeaderView.rawValue)
        
        
        configureDatasource()
        
        getUser()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
//        configureDatasource()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        
        
        
    }
    
    func getUser() {
        
        guard let id = Auth0.uid else {
            self.populateViews()
            return
        }
        
        user = User(id: id)
        
        user?.subscribeModel(completion: { [weak self] res in
            if res != nil {
                self?.populateViews()
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
            
            if let viewController = EditProfileViewController.instantiate() {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
        
    }
    
    func toSettings() {

        DispatchQueue.main.async {
            
            if let viewController = SettingsViewController.instantiate() {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
        
    }
    
    func toContentCollection() {

        DispatchQueue.main.async {
            
            if let viewController = CreationCollectionViewController.instantiate() {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
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
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileHeaderCell.identifiers.profileHeaderCell.rawValue, for: indexPath) as? ProfileHeaderCell {
                cell.configure(with: data)
                return cell
            } else {
                return ProfileHeaderCell()
            }
        case .creation(let data):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreationViewCell.identifiers.creationViewCell.rawValue, for: indexPath) as? CreationViewCell {
                cell.configureCell(at: indexPath.row, creation: data)
                return cell
            } else {
                return CreationViewCell()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            selectedIndex = indexPath.row
            toContentCollection()
        default:
            print("tapped cell")
        }
    }
    
    private func configureDatasource() {
        
        datasource = Datasource(collectionView: collectionView, cellProvider: cell(collectionView:indexPath:item:))
        datasource.apply(snapshot(), animatingDifferences: false)
        datasource.supplementaryViewProvider = supplementary(collectionView:kind:indexPath:)

        configured = true
        
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
        
        
        var thumbnails = [CreationThumbNailView]()
        for i in Testing.defaultCreations {
            thumbnails.append(CreationThumbNailView(model: i))
        }
        
        if thumbnails.count == 0 {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: collectionView.frame.height - 54, right: 0)
        } else if thumbnails.count <= 3 {
            let w = view.frame.width * 5 / 12
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: collectionView.frame.height - 54 - w, right: 0)
        } else if thumbnails.count <= 6 {
            let w = view.frame.width * 5 / 12 * 2
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: collectionView.frame.height - 54 - w, right: 0)
        } else if thumbnails.count <= 9 {
            let w = view.frame.width * 5 / 12 * 3
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: collectionView.frame.height - 54 - w, right: 0)
        } else {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 54, right: 0)
        }
        
        snapshot.appendItems(thumbnails.map({ Item.creation($0) }), toSection: .creations)
        
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
        
        let section = NSCollectionLayoutSection(group: headerGroup)
        
        
        return section
        
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(5/12))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let coverGroupSize1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let coverGroup1 = NSCollectionLayoutGroup.vertical(layoutSize: coverGroupSize1, subitems: [group])
        
        let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let coverGroupSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let coverGroup2 = NSCollectionLayoutGroup.vertical(layoutSize: coverGroupSize2, subitems: [group2])
        
        let coverGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2.0), heightDimension: .fractionalWidth(1))
        let coverGroup = NSCollectionLayoutGroup.horizontal(layoutSize: coverGroupSize, subitems: [coverGroup1, coverGroup2])
        
        let section = NSCollectionLayoutSection(group: coverGroup)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        header.pinToVisibleBounds = true
        
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
        
    }
    
    private func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileCreationsHeaderView.identifiers.profileCreationsHeaderView.rawValue, for: indexPath)
    }
    
}
