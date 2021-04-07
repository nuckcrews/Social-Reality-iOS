//
//  MessageTypes.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/6/21.
//

import Foundation

enum MessageTypes: String {
    
    case message = "MESSAGE"
    case link = "LINK"
    case creation = "CREATION"
    
    var description: String {
        get {
            switch self {
            case .message:
                return "MESSAGE"
            case .link:
                return "LINK"
            case .creation:
                return "CREATION"
            }
        }
    }
    
    static func getMessageType(type: String) -> MessageTypes {
        switch type {
        case "MESSAGE":
            return .message
        case "LINK":
            return .link
        case "CREATION":
            return .creation
        default:
            return .message
        }
    }
    
}

extension MessageTypes: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = MessageTypes.getMessageType(type: rawValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.description)
    }
    
}
