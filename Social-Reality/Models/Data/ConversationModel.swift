//
//  ConversationModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/6/21.
//

import Foundation

struct ConversationModel: Codable, Equatable {
    
    var id: String
    var userIDs: [String]
    var lastMessage: String?
    var lastMessageDate: String?
    var image: String
    
}

extension ConversationModel {
    
    mutating func update(data: [String: Any]) {
        
        for item in data {
            
            if item.key == Fields.conversation.userIDs.rawValue,
               let value = item.value as? [String] {
                userIDs = value
            }
            
            if item.key == Fields.conversation.lastMessage.rawValue,
               let value = item.value as? String {
                lastMessage = value
            }
            
            if item.key == Fields.conversation.lastMessageDate.rawValue,
               let value = item.value as? String {
                lastMessageDate = value
            }
            
            if item.key == Fields.conversation.image.rawValue,
               let value = item.value as? String {
                image = value
            }
            
        }
        
    }
    
}
