//
//  UserModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/18/21.
//

import Foundation
import Firebase
import CodableFirebase

struct UserModel: Codable {
    
    public let id: String
    public var username: String
    public var status: String
    public var first: String
    public var last: String
    public var lastActive: String
    public var email: String
    public var image: String
    public var access: ProfileAccessibility
    
}
