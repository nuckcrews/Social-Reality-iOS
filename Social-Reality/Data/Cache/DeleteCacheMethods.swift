//
//  DeleteCacheMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/26/21.
//

import Foundation

struct DeleteCacheMethods {
    
    private let userCache = NSCache<NSString, UserCacheModel>()
    private let creationCache = NSCache<NSString, CreationCacheModel>()
    private let commentCache = NSCache<NSString, CommentCacheModel>()
    private let likeCache = NSCache<NSString, LikeCacheModel>()
    private let conversationCache = NSCache<NSString, ConversationCacheModel>()
    private let messageCache = NSCache<NSString, MessageCacheModel>()
    
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
