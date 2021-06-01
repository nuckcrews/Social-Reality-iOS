//
//  UpdateCacheMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/26/21.
//

import Foundation

struct UpdateCacheMethods {
    
    private let userCache = NSCache<NSString, UserCacheModel>()
    private let creationCache = NSCache<NSString, CreationCacheModel>()
    private let commentCache = NSCache<NSString, CommentCacheModel>()
    private let likeCache = NSCache<NSString, LikeCacheModel>()
    private let conversationCache = NSCache<NSString, ConversationCacheModel>()
    private let messageCache = NSCache<NSString, MessageCacheModel>()
    
    func user(_ id: String, data: [String: Any]) {
        guard data.count > 0 else { return }
        
        if var model = userCache.object(forKey: id as NSString)?.user {
            model.update(data: data)
        }
        
    }
    
    func creation(_ id: String, data: [String: Any]) {
        guard data.count > 0 else { return }
        
        if var model = creationCache.object(forKey: id as NSString)?.creation {
            model.update(data: data)
        }
        
    }
    
    func comment(_ id: String, data: [String: Any]) {
        guard data.count > 0 else { return }
        
        if var model = commentCache.object(forKey: id as NSString)?.comment {
            model.update(data: data)
        }
        
    }
    
    func like(_ id: String, data: [String: Any]) {
        guard data.count > 0 else { return }
        
        if var model = likeCache.object(forKey: id as NSString)?.like {
            model.update(data: data)
        }
        
    }
    
    func conversation(_ id: String, data: [String: Any]) {
        guard data.count > 0 else { return }
        
        if var model = conversationCache.object(forKey: id as NSString)?.conversation {
            model.update(data: data)
        }
        
    }
    
    func message(_ id: String, data: [String: Any]) {
        guard data.count > 0 else { return }
        
        if var model = messageCache.object(forKey: id as NSString)?.message {
            model.update(data: data)
        }
        
    }
    
}
