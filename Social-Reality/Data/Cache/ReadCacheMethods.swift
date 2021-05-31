//
//  ReadCacheMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/26/21.
//

import Foundation

struct ReadCacheMethods {
    
    private let userCache = NSCache<NSString, UserCacheModel>()
    private let creationCache = NSCache<NSString, CreationCacheModel>()
    private let commentCache = NSCache<NSString, CommentCacheModel>()
    private let likeCache = NSCache<NSString, LikeCacheModel>()
    private let conversationCache = NSCache<NSString, ConversationCacheModel>()
    private let messageCache = NSCache<NSString, MessageCacheModel>()
    
    func user(_ key: String) -> UserModel? {
        guard key.count > 0 else { return nil }
        
        return userCache.object(forKey: key as NSString)?.user
    }
    
    func creation(_ key: String) -> CreationModel? {
        guard key.count > 0 else { return nil }
        
        return creationCache.object(forKey: key as NSString)?.creation
    }
    
    func comment(_ key: String) -> CommentModel? {
        guard key.count > 0 else { return nil }
        
        return commentCache.object(forKey: key as NSString)?.comment
    }
    
    func like(_ key: String) -> LikeModel? {
        guard key.count > 0 else { return nil }
        
        return likeCache.object(forKey: key as NSString)?.like
    }
    
    func conversation(_ key: String) -> ConversationModel? {
        guard key.count > 0 else { return nil }
        
        return conversationCache.object(forKey: key as NSString)?.conversation
    }
    
    func message(_ key: String) -> MessageModel? {
        guard key.count > 0 else { return nil }
        
        return messageCache.object(forKey: key as NSString)?.message
    }
    
}
