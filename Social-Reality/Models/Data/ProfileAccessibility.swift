//
//  ProfileAccessibility.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/18/21.
//

import Foundation
import Firebase
import CodableFirebase

public enum ProfileAccessibility: String {
    
    case `public` = "PUBLIC"
    case `private` = "PRIVATE"
    case professional = "PROFESSIONAL"
    
    var description: String {
        get {
            switch self {
            case .public:
                return "PUBLIC"
            case .private:
                return "PRIVATE"
            case .professional:
                return "PROFESSIONAL"
            }
        }
    }
    
    static func getAccessType(access: String) -> ProfileAccessibility {
        switch access {
        case "PUBLIC":
            return .public
        case "PRIVATE":
            return .private
        case "PROFESSIONAL":
            return .professional
        default:
            return .public
        }
    }
    
    
}

extension ProfileAccessibility: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = ProfileAccessibility.getAccessType(access: rawValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.description)
    }
    
}
