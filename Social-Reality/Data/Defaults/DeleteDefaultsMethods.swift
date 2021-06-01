//
//  DeleteDefaultsMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/31/21.
//

import Foundation

struct DeleteDefaultsMethods {
    
    private let defaults = UserDefaults.standard
    
    func user(_ id: String) {
        defaults.removeObject(forKey: id)
    }
    
}
