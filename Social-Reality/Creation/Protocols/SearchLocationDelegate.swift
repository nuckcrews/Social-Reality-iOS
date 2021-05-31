//
//  SearchLocationDelegate.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/31/21.
//

import Foundation

protocol SearchLocationDelegate: AnyObject {
    func selectLocation(location: SearchLocation?)
    func dismissSearchLocationView()
}
