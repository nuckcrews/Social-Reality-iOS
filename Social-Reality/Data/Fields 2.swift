//
//  Fields.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/8/21.
//

import Foundation

struct Fields {
    
    enum user: String {
        
        case id
        case username
        case status
        case first
        case last
        case lastActive
        case email
        case image
        case access
        case fcmToken
        
    }
    
    enum creation: String {
        
        case id
        case title
        case description
        case lastViewed
        case accessibility
        case status
        case date
        case userID
        case userName
        case userImage
        case videoURL
        case thumbnail
        
    }
    
    enum comment: String {
        
        case id
        case content
        case status
        case creationID
        case userID
        case userImage
        case userName
        case date
        
    }
    
    enum like: String {
        
        case id
        case status
        case creationID
        case userID
        case userImage
        case userName
        
    }

    enum conversation: String {
        
        case idcase
        case userIDs
        case lastMessage
        case lastMessageDate
        case imagecase
        
    }

    enum message: String {
        
        case id
        case conversationID
        case senderIDcase
        case recipientIDcase
        case contentcase
        case datecase
        case type
        
        case creationID
        case creationImage
        case creationUserName
        case creationUserImage
        case creationCaption
        
    }
    
}


