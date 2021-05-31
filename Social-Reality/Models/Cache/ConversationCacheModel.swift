//
//  ConversationCacheModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation

final class ConversationCacheModel {
    
    public var conversation: ConversationModel?
    
    init?(_ model: ConversationModel?) {
        if let model = model {
            conversation = model
        } else {
            return nil
        }
    }
    
}
