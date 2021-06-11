//
//  UserLikeModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 6/10/21.
//

import Foundation

struct UserLikeModel: Codable, Equatable {
    
    public let id: String
    public var creationID: String
    public var thumbnail: String
    public var userID: String
    public var userImage: String
    
}
