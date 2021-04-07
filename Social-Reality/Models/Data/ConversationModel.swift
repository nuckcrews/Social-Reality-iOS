//
//  ConversationModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/6/21.
//

import Foundation

struct ConversationModel: Codable {
    
    var id: String
    var userIDs: [String]
    var lastMessage: String?
    var lastMessageDate: String?
    var image: String
    
}
