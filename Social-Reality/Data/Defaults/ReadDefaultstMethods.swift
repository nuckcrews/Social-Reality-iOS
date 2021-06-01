//
//  ReadDefaultsMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/31/21.
//

import Foundation

struct ReadDefaultsMethods {
    
    private let defaults = UserDefaults.standard
    
    func user(_ id: String) -> UserModel? {
        guard let decoded = defaults.object(forKey: id) as? Data else { return nil }
        do {
            return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? UserModel
        } catch {
            return nil
        }
        
    }
    
}
