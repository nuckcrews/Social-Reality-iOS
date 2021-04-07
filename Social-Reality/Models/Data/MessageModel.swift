//
//  MessageModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/6/21.
//

import Foundation

struct MessageModel: Codable {
    
    var id: String
    var conversationID: String
    var senderID: String
    var recipientID: String
    var content: String
    var date: String
    var type: MessageTypes
    
}
