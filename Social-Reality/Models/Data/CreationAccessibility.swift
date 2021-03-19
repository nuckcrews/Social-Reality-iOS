//
//  CreationAccessibility.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/18/21.
//

import Foundation
import Firebase
import CodableFirebase

public enum CreationAccessibility: String {
    
    case `public` = "PUBLIC"
    case `private` = "PRIVATE"
    case personal = "PERSONAL"
    
    var description: String {
        get {
            switch self {
            case .public:
                return "PUBLIC"
            case .private:
                return "PRIVATE"
            case .personal:
                return "PERSONAL"
            }
        }
    }
    
    static func getAccessType(access: String) -> CreationAccessibility {
        switch access {
        case "PUBLIC":
            return .public
        case "PRIVATE":
            return .private
        case "PERSONAL":
            return .personal
        default:
            return .public
        }
    }
    
    
}

extension CreationAccessibility: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = CreationAccessibility.getAccessType(access: rawValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.description)
    }
    
}
