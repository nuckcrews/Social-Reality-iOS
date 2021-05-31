//
//  LikeModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/18/21.
//

import Foundation

struct LikeModel : Codable, Equatable {
    
    public let id: String
    public var status: String?
    public var creationID: String?
    public var userID: String?
    public var userImage: String?
    public var userName: String?
    
}
