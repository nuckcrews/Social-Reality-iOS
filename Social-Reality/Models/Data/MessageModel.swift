//
//  MessageModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/6/21.
//

import Foundation

struct MessageModel: Codable, Equatable {
    
    var id: String
    var conversationID: String
    var senderID: String
    var recipientID: String
    var content: String
    var date: String
    var type: MessageTypes
    
    var creationID: String?
    var creationImage: String?
    var creationUserName: String?
    var creationUserImage: String?
    var creationCaption: String?
    
}

extension MessageModel {
    
    mutating func update(data: [String: Any]) {
        
        for item in data {
            
            if item.key == Fields.message.conversationID.rawValue,
               let value = item.value as? String {
                conversationID = value
            }
            
            if item.key == Fields.message.senderID.rawValue,
               let value = item.value as? String {
                senderID = value
            }
            
            if item.key == Fields.message.recipientID.rawValue,
               let value = item.value as? String {
                recipientID = value
            }
            
            if item.key == Fields.message.content.rawValue,
               let value = item.value as? String {
                content = value
            }
            
            if item.key == Fields.message.date.rawValue,
               let value = item.value as? String {
                date = value
            }
            
            if item.key == Fields.message.type.rawValue,
               let value = item.value as? MessageTypes {
                type = value
            }
            
            if item.key == Fields.message.creationID.rawValue,
               let value = item.value as? String {
                creationID = value
            }
            
            if item.key == Fields.message.creationImage.rawValue,
               let value = item.value as? String {
                creationImage = value
            }
            
            if item.key == Fields.message.creationUserName.rawValue,
               let value = item.value as? String {
                creationUserName = value
            }
            
            if item.key == Fields.message.creationUserImage.rawValue,
               let value = item.value as? String {
                creationImage = value
            }
            
            if item.key == Fields.message.creationCaption.rawValue,
               let value = item.value as? String {
                creationCaption = value
            }
            
        }
        
    }
    
}
