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
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var topMapView: UIView!
    @IBOutlet weak var contentScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.tag = TabbarItemTag.secondViewConroller.rawValue
        
        searchTextField.delegate = self
        contentScrollView.delegate = self
        
        setupMapView()
        
    }
    
    func setupMapView() {
        
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        
        // Set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        mapView.camera = GMSCameraPosition(target: initialLocation.coordinate, zoom: 14)
        
    }
    
    @IBAction func tapMapView(_ sender: AnyObject) {
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
            self.searchView.alpha = 0
        } completion: { _ in
            print("Opened Map")
        }

        searchView.alpha = 0
    }

    
}

extension ExploreViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == contentScrollView {
            if scrollView.contentOffset.y >= topMapView.frame.height {
                scrollView.contentOffset.y = topMapView.frame.height
            }
        }
    }
}

extension ExploreViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
            self.searchView.alpha = 1
        } completion: { _ in
            print("Opened Map")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension ExploreViewController: GMSMapViewDelegate {
    
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
