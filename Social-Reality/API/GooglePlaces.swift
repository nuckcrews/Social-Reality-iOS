//
//  GooglePlaces.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/25/21.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces

struct Places {
    
    var placesClient = GMSPlacesClient()
    
    func autoComplete(searchText: String, completion: @escaping(_ result: [SearchLocation]?) -> Void) {
        
        let token = GMSAutocompleteSessionToken.init()
        
        // Create a type filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        
        placesClient.findAutocompletePredictions(fromQuery: searchText, filter: nil, sessionToken: token)
        { results, error in
            if let error = error {
                print("Autocomplete error: \(error)")
                completion(nil)
                return
            }
            if let results = results {
                var locations = [SearchLocation]()
                for result in results {
                    print("Result \(result.attributedFullText) with placeID \(result.placeID)")
                    let loc = SearchLocation(name: result.attributedFullText.string,
                                             id: result.placeID,
                                             topAddress: result.attributedPrimaryText.string,
                                             bottomAddress: result.attributedSecondaryText?.string,
                                             types: result.types)
                    locations.append(loc)
                }
                completion(locations)
            } else {
                completion(nil)
            }
        }
        
    }
    
}

struct SearchLocation {
    
    var name: String?
    var id: String?
    var topAddress: String?
    var bottomAddress: String?
    var types: [String]?
    
}
