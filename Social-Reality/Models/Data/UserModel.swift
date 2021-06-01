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
    
    mutating func update(data: [String: Any]) {
        
        for item in data {
            
            if item.key == Fields.user.username.rawValue,
               let value = item.value as? String {
                username = value
            }
            
            if item.key == Fields.user.status.rawValue,
               let value = item.value as? String {
                status = value
            }
            
            if item.key == Fields.user.first.rawValue,
               let value = item.value as? String {
                first = value
            }
            
            if item.key == Fields.user.last.rawValue,
               let value = item.value as? String {
                last = value
            }
            
            if item.key == Fields.user.lastActive.rawValue,
               let value = item.value as? String {
                lastActive = value
            }
            
            if item.key == Fields.user.email.rawValue,
               let value = item.value as? String {
                email = value
            }
            
            if item.key == Fields.user.image.rawValue,
               let value = item.value as? String {
                image = value
            }
            
            if item.key == Fields.user.access.rawValue,
               let value = item.value as? ProfileAccessibility {
                access = value
            }
            
            if item.key == Fields.user.fcmToken.rawValue,
               let value = item.value as? String {
                fcmToken = value
            }
            
        }
        
    }
    
}
