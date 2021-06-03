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
    private let videoCache = NSCache<NSString, VideoCacheModel>()
    
    func user(_ key: String) {
        guard key.count > 0 else { return }
        
        userCache.removeObject(forKey: key as NSString)
    }
    
    func creation(_ key: String) {
        guard key.count > 0 else { return }
        
        creationCache.removeObject(forKey: key as NSString)
    }
    
    func comment(_ key: String) {
        guard key.count > 0 else { return }
        
        commentCache.removeObject(forKey: key as NSString)
    }
    
    func like(_ key: String) {
        guard key.count > 0 else { return }
        
        likeCache.removeObject(forKey: key as NSString)
    }
    
    func conversation(_ key: String) {
        guard key.count > 0 else { return }
        
        conversationCache.removeObject(forKey: key as NSString)
    }
    
    func message(_ key: String) {
        guard key.count > 0 else { return }
        
        messageCache.removeObject(forKey: key as NSString)
    }
    
    func video(_ key: String) {
        guard key.count > 0 else { return }
        
        videoCache.removeObject(forKey: key as NSString)
    }
    
    func removeAllUsers() {
        userCache.removeAllObjects()
    }
    
    func removeAllCreations() {
        creationCache.removeAllObjects()
    }
    
    func removeAllComments() {
        commentCache.removeAllObjects()
    }
    
    func removeAllLikes() {
        likeCache.removeAllObjects()
    }
    
    func removeAllConversations() {
        conversationCache.removeAllObjects()
    }
    
    func removeAllMessages() {
        messageCache.removeAllObjects()
    }
    
    func removeAllVideos() {
        videoCache.removeAllObjects()
    }
    
    func removeAll() {
        userCache.removeAllObjects()
        creationCache.removeAllObjects()
        commentCache.removeAllObjects()
        likeCache.removeAllObjects()
        conversationCache.removeAllObjects()
        messageCache.removeAllObjects()
        videoCache.removeAllObjects()
    }
    
}
