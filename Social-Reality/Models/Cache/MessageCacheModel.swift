//
//  MessageCacheModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation

final class MessageCacheModel {
    
    public var message: MessageModel?
    
    init?(_ model: MessageModel?) {
        if let model = model {
            message = model
        } else {
            return nil
        }
    }
    
}
