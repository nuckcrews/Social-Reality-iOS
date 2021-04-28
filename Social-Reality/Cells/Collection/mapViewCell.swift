//
//  mapViewCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/4/21.
//

import UIKit
import GoogleMaps
import GooglePlaces

// MARK: - Map View Cell

class mapViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    // MARK: - Variables
    
    weak var cellDelegate: MapCellDelegate?
    
    // MARK: - Configure Methods
    
    func configure(with data: MapHeaderData, delegate: MapCellDelegate) {
        
        cellDelegate = delegate
        setupMapView(location: data.location)
        
    }
    
    func setupMapView(location: CLLocation) {
        
        mapView.delegate = self
        mapView.settings.myLocationButton = false
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 14)
        
    }
    
    // MARK: - Action outlets
    
    @IBAction func tapMap(_ sender: UIButton) {
        sender.pulsate()
        cellDelegate?.tappedMap()
    }
    
}

// MARK: - Map View Delegate

extension mapViewCell: GMSMapViewDelegate {}

// MARK: - Map Cell Delegate

protocol MapCellDelegate: NSObjectProtocol {
    func tappedMap()
}
