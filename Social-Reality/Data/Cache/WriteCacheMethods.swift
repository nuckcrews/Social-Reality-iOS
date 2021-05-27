//
//  WriteCacheMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/26/21.
//

import Foundation

struct WriteCacheMethods {
 
    private let userCache = NSCache<NSString, UserCacheModel>()
    
    func user(_ model: UserModel) -> UserModel? {
        guard model.id.count > 0, let cacheModel = UserCacheModel(model) else { return nil }
        
        userCache.setObject(cacheModel, forKey: model.id as NSString)
        
        return model
    }
    
}
