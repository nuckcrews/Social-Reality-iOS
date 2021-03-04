//
//  mapViewCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/4/21.
//

import UIKit
import GoogleMaps
import GooglePlaces

class mapViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    weak var cellDelegate: MapCellDelegate?
    
    func configure(with data: MapHeaderData, delegate: MapCellDelegate) {
        
        cellDelegate = delegate
        setupMapView(location: data.lcoation)
    }
    
    func setupMapView(location: CLLocation) {
        
        mapView.delegate = self
        mapView.settings.myLocationButton = false
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 14)
        
    }
    
    @IBAction func tapMap(_ sender: UIButton) {
        sender.pulsate()
        cellDelegate?.tappedMap()
    }
    
}

extension mapViewCell: GMSMapViewDelegate {
    
}

protocol MapCellDelegate: NSObjectProtocol {
    func tappedMap()
}
