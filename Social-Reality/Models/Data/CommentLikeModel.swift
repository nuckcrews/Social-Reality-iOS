//
//  CommentLikeModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 6/10/21.
//

import Foundation

struct CommentLikeModel : Codable, Equatable {
    
    public let id: String
    public var status: String?
    public var commentID: String?
    public var userID: String?
    public var userImage: String?
    public var userName: String?
    
}

extension CommentLikeModel {
    
    mutating func update(data: [String: Any]) {
        
        for item in data {
            
            if item.key == Fields.commentLike.status.rawValue,
               let value = item.value as? String {
                status = value
            }
            
            if item.key == Fields.commentLike.commentID.rawValue,
               let value = item.value as? String {
                commentID = value
            }
            
            if item.key == Fields.commentLike.userID.rawValue,
               let value = item.value as? String {
                userID = value
            }
            
            if item.key == Fields.commentLike.userImage.rawValue,
               let value = item.value as? String {
                userImage = value
            }
            
            if item.key == Fields.commentLike.userName.rawValue,
               let value = item.value as? String {
                userName = value
            }
            
        }
        
    }
    
}
