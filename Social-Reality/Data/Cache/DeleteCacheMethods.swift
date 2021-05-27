//
//  DeleteCacheMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/26/21.
//

import Foundation

struct DeleteCacheMethods {
    
    private let userCache = NSCache<NSString, UserCacheModel>()
    
    func user(_ key: String) {
        guard key.count > 0 else { return }
        
        userCache.removeObject(forKey: key as NSString)
    }
    
    func removeAllUsers() {
        userCache.removeAllObjects()
    }
    
    func removeAll() {
        userCache.removeAllObjects()
    }
    
}
