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
    
    func autoComplete(searchText: String, filter: GMSAutocompleteFilter?, completion: @escaping(_ result: [SearchLocation]?) -> Void) {
        
        let token = GMSAutocompleteSessionToken.init()
        
        placesClient.findAutocompletePredictions(fromQuery: searchText, filter: filter, sessionToken: token)
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
    
    func nearbyLocations(completion: @escaping(_ result: [SearchLocation]?) -> Void) {
        
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                    UInt(GMSPlaceField.placeID.rawValue) |
                                                    UInt(GMSPlaceField.types.rawValue) |
                                                    UInt(GMSPlaceField.formattedAddress.rawValue))
        
        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: fields, callback: {
            (placeLikelihoodList: Array<GMSPlaceLikelihood>?, error: Error?) in
            if let error = error {
                print("An error occurred: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                var locations = [SearchLocation]()
                for likelihood in placeLikelihoodList {
                    let place = likelihood.place
                    print("Current Place name \(String(describing: place.name)) at likelihood \(likelihood.likelihood)")
                    print("Current PlaceID \(String(describing: place.placeID))")
                    let loc = SearchLocation(name: place.name,
                                             id: place.placeID,
                                             topAddress: place.name,
                                             bottomAddress: place.formattedAddress,
                                             types: place.types)
                    locations.append(loc)
                }
                completion(locations)
            } else {
                completion(nil)
            }
        })
        
    }
    
}

struct SearchLocation {
    
    var name: String?
    var id: String?
    var topAddress: String?
    var bottomAddress: String?
    var types: [String]?
    
}
