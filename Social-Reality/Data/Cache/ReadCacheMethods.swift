//
//  ReadCacheMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/26/21.
//

import Foundation

struct ReadCacheMethods {
    
    private let userCache = NSCache<NSString, UserCacheModel>()
    
    func user(_ key: String) -> UserModel? {
        guard key.count > 0 else { return nil }
        
        return userCache.object(forKey: key as NSString)?.user
    }
    
}
