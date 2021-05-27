//
//  UserCacheModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/26/21.
//

import Foundation

final class UserCacheModel {
    
    public var user: UserModel?
    
    init?(_ model: UserModel?) {
        if let model = model {
            user = model
        } else {
            return nil
        }
    }
    
}
