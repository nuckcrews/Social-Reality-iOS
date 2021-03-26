//
//  SearchLocationView.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/25/21.
//

import UIKit
import GoogleMaps
import GooglePlaces

class SearchLocationView: UIView {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var locations = [SearchLocation]()
    var locationsFiltered = [SearchLocation]()
    
    var selectedLocation: SearchLocation?
    var isSearching = false
    var displaying = false
    
    weak var delegate: SearchLocationDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupView()
        
    }
    
    func setupView() {
        
        layer.cornerRadius = 12
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.searchTextField.leftView?.tintColor = .primary
        
    }
    
    func presented() {
        searchBar.becomeFirstResponder()
    }
    
    func isSelected(model: SearchLocation) -> Bool {
        return model.id == selectedLocation?.id
    }
    
    @IBAction func tapDone(_ sender: UIButton) {
        sender.pulsate()
        self.endEditing(true)
        searchBar.resignFirstResponder()
        delegate?.dismissSearchLocationView()
    }
    
}

extension SearchLocationView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearching = searchText.count > 0
        
        print("text:", searchText)
        Places().autoComplete(searchText: searchText) { locs in
            guard let locs = locs else {
                print("error")
                return }
            print(locs)
            self.locations = locs
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

extension SearchLocationView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
}

extension SearchLocationView: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.searchLocationCell.rawValue, for: indexPath) as? searchLocationCell {
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
        
        
        if isSelected(model: locations[indexPath.row]) {
            selectedLocation = nil
        } else {
            selectedLocation = locations[indexPath.row]
        }
        
        delegate?.selectLocation(location: selectedLocation)
        
        cell.tapSelect()
        
    }
    
}


protocol SearchLocationDelegate: AnyObject {
    func selectLocation(location: SearchLocation?)
    func dismissSearchLocationView()
}
