//
//  ExploreViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.tag = TabbarItemTag.secondViewConroller.rawValue
        
        setupMapView()
        
    }
    
    func setupMapView() {
        mapView.settings.myLocationButton = true
        
        // Set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        mapView.camera = GMSCameraPosition(target: initialLocation.coordinate, zoom: 14)
        
    }

    
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
