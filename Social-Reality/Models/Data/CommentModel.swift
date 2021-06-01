//
//  CommentModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/18/21.
//

import Foundation

struct CommentModel: Codable, Equatable {
    
    public let id: String
    public var content: String
    public var status: String?
    public var creationID: String?
    public var userID: String?
    public var userImage: String?
    public var userName: String?
    public var date: String?
    
}

extension CommentModel {
    
    mutating func update(data: [String: Any]) {
        
        for item in data {
            
            if item.key == Fields.comment.content.rawValue,
               let value = item.value as? String {
                content = value
            }
            
            if item.key == Fields.comment.status.rawValue,
               let value = item.value as? String {
                status = value
            }
            
            if item.key == Fields.comment.creationID.rawValue,
               let value = item.value as? String {
                creationID = value
            }
            
            if item.key == Fields.comment.userID.rawValue,
               let value = item.value as? String {
                userID = value
            }
            
            if item.key == Fields.comment.userImage.rawValue,
               let value = item.value as? String {
                userImage = value
            }
            
            if item.key == Fields.comment.userName.rawValue,
               let value = item.value as? String {
                userName = value
            }
            
            if item.key == Fields.comment.date.rawValue,
               let value = item.value as? String {
                date = value
            }
            
        }
        
    }
}
