//
//  SearchLocationView.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/25/21.
//

import UIKit
import GoogleMaps
import GooglePlaces

// MARK: - Search Location Utility View

class SearchLocationView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var doneButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var locations = [SearchLocation]()
    var locationsFiltered = [SearchLocation]()
    
    var selectedLocation: SearchLocation?
    var isSearching = false
    var displaying = false
    private var setup = false
    
    private var defaultBottomConstraint: CGFloat = 44
    
    private let locationManager: CLLocationManager = CLLocationManager()
    
    weak var delegate: SearchLocationDelegate?
    
    // MARK: - View LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !setup {
            setupLocationManager()
            setupView()
            setup = true
        }
        
    }
    
    func presented() {
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - View Setup
    
    func setupView() {
        
        layer.cornerRadius = 12
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.searchTextField.leftView?.tintColor = .primary
        
        doneButtonBottomConstraint.priority = .defaultLow
        doneButtonBottomConstraint.constant = defaultBottomConstraint
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // MARK: - Location Fetching
    
    func getNearbyLocations() {
        
        guard let _ = locationManager.location else { return }
        
        Places().nearbyLocations { locs in
            guard let locs = locs else { return }
            self.locations = locs
            self.tableView.reloadData()
        }
        
    }
    
    func isSelected(model: SearchLocation) -> Bool {
        return model.id == selectedLocation?.id
    }
    
    // MARK: - Keyboard Observers
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            doneButtonBottomConstraint.constant = keyboardSize.height + 8
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        doneButtonBottomConstraint.constant = defaultBottomConstraint
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - Action Outlets
    
    @IBAction func tapDone(_ sender: UIButton) {
        sender.pulsate()
        self.endEditing(true)
        searchBar.resignFirstResponder()
        delegate?.dismissSearchLocationView()
    }
    
}

// MARK: - Search Bar Delegate

extension SearchLocationView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearching = searchText.count > 0
        
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        
        Places().autoComplete(searchText: searchText, filter: filter) { locs in
            guard let locs = locs else { print("error"); return }
            self.locationsFiltered = locs
        }
        
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.endEditing(true)
        searchBar.resignFirstResponder()
        delegate?.dismissSearchLocationView()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.endEditing(true)
        searchBar.resignFirstResponder()
        delegate?.dismissSearchLocationView()
    }
    
}

// MARK: - ScrollView Delegate

extension SearchLocationView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - TableViewDelegate

extension SearchLocationView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            if locationsFiltered.count > 0 {
                tableView.alpha = 1
            } else {
                tableView.alpha = 0
            }
            return locationsFiltered.count
        } else {
            if locations.count > 0 {
                tableView.alpha = 1
            } else {
                tableView.alpha = 0
            }
            return locations.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.searchLocationCell.rawValue, for: indexPath) as? searchLocationCell {
            isSearching ?
                cell.configureCell(location: locationsFiltered[indexPath.row],
                                   selectedCell: isSelected(model: locationsFiltered[indexPath.row])) :
                cell.configureCell(location: locations[indexPath.row],
                                   selectedCell: isSelected(model: locations[indexPath.row]))
            
            return cell
        } else {
            return searchLocationCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? searchLocationCell else {
            return
        }
        
        if isSearching {
            if isSelected(model: locationsFiltered[indexPath.row]) {
                selectedLocation = nil
            } else {
                selectedLocation = locationsFiltered[indexPath.row]
            }
        } else {
            if isSelected(model: locations[indexPath.row]) {
                selectedLocation = nil
            } else {
                selectedLocation = locations[indexPath.row]
            }
        }
        
        
        delegate?.selectLocation(location: selectedLocation)
        
        cell.tapSelect()
        
    }
    
}

// MARK: - Location Manager Delegate

extension SearchLocationView: CLLocationManagerDelegate {
    
    private func setupLocationManager() {
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        getNearbyLocations()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied, .notDetermined:
            break
        case .authorizedWhenInUse, .authorizedAlways:
            break
        @unknown default:
            print("Unknown Authorization Case")
        }
    }
    
}

