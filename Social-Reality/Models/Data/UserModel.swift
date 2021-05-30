//
//  UserModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/18/21.
//

import Foundation

struct UserModel: Codable, Equatable {
    
    public let id: String
    public var username: String
    public var status: String
    public var first: String
    public var last: String
    public var lastActive: String
    public var email: String
    public var image: String
    public var access: ProfileAccessibility
    public var fcmToken: String
    
}

extension UserModel {
    
    func update(data: [String: Any]) -> UserModel {
        
        // Need to convert data into model
        
    }
    
}
