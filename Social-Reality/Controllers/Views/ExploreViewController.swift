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

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var topMapView: UIView!
    
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
        case creation(CreationView)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.tag = TabBarItemTag.secondViewController.rawValue
        
        searchTextField.delegate = self
        
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        collectionView.register(ExploreMapHeaderView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Cells.ExploreMapHeaderView.rawValue)
        collectionView.register(ExploreCreationHeaderView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Cells.ExploreCreationHeaderView.rawValue)
        
//        collectionView.register(creationViewCell.self, forCellWithReuseIdentifier: Cells.creationViewCell.rawValue)
        
        configureDatasource()
        setupLocationManager()
        
    }
    
    func setupMapView(userLocation: Bool) {
        
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        
        // Set initial location in Honolulu
        let initialLocation = userLocation ? locationManager.location : CLLocation(latitude: 21.282778, longitude: -157.829444)
        mapView.camera = GMSCameraPosition(target: initialLocation?.coordinate ?? CLLocation(latitude: 21.282778, longitude: -157.829444).coordinate, zoom: 14)
        
        reloadDataSource()
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
extension ExploreViewController: GMSMapViewDelegate {
    
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
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.mapViewCell.rawValue, for: indexPath) as? mapViewCell {
                cell.configure(with: data, delegate: self)
                return cell
            } else {
                return mapViewCell()
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
        snapshot.appendItems(CreationView.demoPhotos.map({ Item.creation($0) }), toSection: .creations)
        snapshot.appendItems(CreationView.demoPhotos2.map({ Item.creation($0) }), toSection: .creations)
        
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
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(42))
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        header.pinToVisibleBounds = true
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }
    
    private func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Cells.ExploreMapHeaderView.rawValue, for: indexPath)
        } else {
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Cells.ExploreCreationHeaderView.rawValue, for: indexPath)
        }
        
    }
    
}
