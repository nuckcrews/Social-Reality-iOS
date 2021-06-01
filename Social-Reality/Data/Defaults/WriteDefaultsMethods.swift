//
//  WriteDefaultsMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/31/21.
//

import Foundation

struct WriteDefaultsMethods {
    
    private let defaults = UserDefaults.standard
    
    func user(_ model: UserModel) {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: false)
            defaults.set(encodedData, forKey: model.id)
        } catch {
            print("User Defaults Error")
        }
    }
    
}
