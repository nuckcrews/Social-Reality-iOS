//
//  ExploreViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

// MARK: - Explore View Controller -> Tab 2

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var topMapView: UIView!
    
    var creations = [CreationModel]()
    var creationThumbNails = [CreationThumbNailView]()
    var selectedIndex = 0
    
    private var datasource: Datasource!
    private let locationManager: CLLocationManager = CLLocationManager()
    
    typealias Datasource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    enum Section: Hashable {
        case map
        case creations
    }
    
    enum Item: Hashable {
        case map(MapHeaderData)
        case creation(CreationThumbNailView)
    }
    
    // MARK: - View Instantiation
    
    internal static func instantiate() -> ExploreViewController? {

        guard let viewController = Storyboard.ExploreViewController.instantiate(ExploreViewController.self) else {
            return nil
        }
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.tag = TabBarItemTag.secondViewController.rawValue
        
        searchTextField.delegate = self
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        collectionView.register(ExploreMapHeaderView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ExploreMapHeaderView.identifiers.exploreMapHeaderView.rawValue)
        collectionView.register(ExploreCreationHeaderView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ExploreCreationHeaderView.identifiers.exploreCreationHeaderView.rawValue)
        
        configureDatasource()
        setupLocationManager()
        
        fetchCreations()
        
    }
    
    func setupMapView(userLocation: Bool) {
        
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        
        // Set initial location in Honolulu
        let initialLocation = userLocation ? locationManager.location : CLLocation(latitude: 21.282778, longitude: -157.829444)
        mapView.camera = GMSCameraPosition(target: initialLocation?.coordinate ?? CLLocation(latitude: 21.282778, longitude: -157.829444).coordinate, zoom: 14)
        
        reloadDataSource()
    }
    
    func fetchCreations() {
        
        // #SCALEFIX
        Query.remote.get.creations { [weak self] models in
            guard let models = models else { return }
            self?.creations.removeAll()
            self?.creationThumbNails.removeAll()
            for model in models {
                self?.creations.append(model)
                self?.creationThumbNails.append(CreationThumbNailView(model: model))
            }
            self?.reloadDataSource()
        }
        
    }
    
    // MARK: - Segues
    
    func toCreationTableView() {

        DispatchQueue.main.async {
            
            if let viewController = CreationTableViewController.instantiate(creations: self.creations, selectedIndex: self.selectedIndex) {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
    }
    
}
extension ExploreViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
            self.searchView.alpha = 1
            self.topMapView.alpha = 1
        } completion: { _ in
            print("Opened Map")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}
extension ExploreViewController: CLLocationManagerDelegate {
    
    private func setupLocationManager() {
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        setupMapView(userLocation: locationManager.authorizationStatus)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied, .notDetermined:
            setupMapView(userLocation: false)
            break
        case .authorizedWhenInUse, .authorizedAlways:
            setupMapView(userLocation: true)
            break
        @unknown default:
            print("Unknown Authorization Case")
        }
    }
    
}

extension ExploreViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
        searchTextField.resignFirstResponder()
    }
    
}

extension ExploreViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if gesture {
            view.endEditing(true)
        }
    }
    
}
extension ExploreViewController: MapCellDelegate {
    
    func tappedMap() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.searchView.alpha = 0
            self.topMapView.alpha = 0
        } completion: { _ in }
    }
    
}
extension ExploreViewController {
    
    private func cell(collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell {
        switch item {
        case .map(let data):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapViewCell.identifiers.mapViewCell.rawValue, for: indexPath) as? MapViewCell {
                cell.configure(with: data, delegate: self)
                return cell
            } else {
                return MapViewCell()
            }
        case .creation(let data):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreationViewCell.identifiers.creationViewCell.rawValue, for: indexPath) as? CreationViewCell {
                cell.configureCell(at: indexPath.row, creation: data, del: self)
                return cell
            } else {
                return CreationViewCell()
            }
            
        }
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
        
        let initialLocation = locationManager.authorizationStatus ? locationManager.location : CLLocation(latitude: 21.282778, longitude: -157.829444)
        snapshot.appendSections([.map, .creations])
        snapshot.appendItems([.map(MapHeaderData(location: initialLocation ?? CLLocation(latitude: 21.282778, longitude: -157.829444)))], toSection: .map)
        snapshot.appendItems(creationThumbNails.map({ Item.creation($0) }), toSection: .creations)
        
        return snapshot
    }
    
}

extension ExploreViewController {
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: sectionFor(index:environment:))
    }
    
    func createHeaderSection() -> NSCollectionLayoutSection {
        
        let headerItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        let headerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200)), subitems: [headerItem])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(48))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        header.pinToVisibleBounds = true
        
        let section = NSCollectionLayoutSection(group: headerGroup)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func sectionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = datasource.snapshot().sectionIdentifiers[index]
        
        switch section {
        case .map:
            return createHeaderSection()
        case .creations:
            return createCreationsSection()
        }
    }
    
    func createCreationsSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(3/8))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(48))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        header.pinToVisibleBounds = true
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }
    
    private func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ExploreMapHeaderView.identifiers.exploreMapHeaderView.rawValue, for: indexPath)
        } else {
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ExploreCreationHeaderView.identifiers.exploreCreationHeaderView.rawValue, for: indexPath)
        }
        
    }
    
}

extension ExploreViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        toCreationTableView()
        print("selecting")
        selectedIndex = indexPath.row
    }
    
}

extension ExploreViewController: CreationViewDelegate {
    
    func tappedView(index: Int) {
        toCreationTableView()
        selectedIndex = index
    }
    
}
