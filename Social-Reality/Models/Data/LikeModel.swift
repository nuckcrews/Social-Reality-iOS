//
//  LikeModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/18/21.
//

import Foundation

struct LikeModel : Codable, Equatable {
    
    public let id: String
    public var status: String?
    public var creationID: String?
    public var userID: String?
    public var userImage: String?
    public var userName: String?
    
}

extension LikeModel {
    
    mutating func update(data: [String: Any]) {
        
        for item in data {
            
            if item.key == Fields.like.status.rawValue,
               let value = item.value as? String {
                status = value
            }
            
            if item.key == Fields.like.creationID.rawValue,
               let value = item.value as? String {
                creationID = value
            }
            
            if item.key == Fields.like.userID.rawValue,
               let value = item.value as? String {
                userID = value
            }
            
            if item.key == Fields.like.userImage.rawValue,
               let value = item.value as? String {
                userImage = value
            }
            
            if item.key == Fields.like.userName.rawValue,
               let value = item.value as? String {
                userName = value
            }
            
        }
        
    }
    
}
