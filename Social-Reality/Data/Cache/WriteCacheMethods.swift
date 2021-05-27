//
//  WriteCacheMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/26/21.
//

import Foundation

struct WriteCacheMethods {
 
    private let userCache = NSCache<NSString, UserCacheModel>()
    private let creationCache = NSCache<NSString, CreationCacheModel>()
    private let commentCache = NSCache<NSString, CommentCacheModel>()
    private let likeCache = NSCache<NSString, LikeCacheModel>()
    private let conversationCache = NSCache<NSString, ConversationCacheModel>()
    private let messageCache = NSCache<NSString, MessageCacheModel>()
    
    func user(_ model: UserModel) {
        guard model.id.count > 0,
              let cacheModel = UserCacheModel(model)
        else { return }
        
        userCache.setObject(cacheModel, forKey: model.id as NSString)
    }
    
    func creation(_ model: CreationModel) {
        guard model.id.count > 0,
              let cacheModel = CreationCacheModel(model)
        else { return }
        
        creationCache.setObject(cacheModel, forKey: model.id as NSString)
    }
    
    func comment(_ model: CommentModel) {
        guard model.id.count > 0,
              let cacheModel = CommentCacheModel(model)
        else { return }
        
        commentCache.setObject(cacheModel, forKey: model.id as NSString)
    }
    
    func like(_ model: LikeModel) {
        guard model.id.count > 0,
              let cacheModel = LikeCacheModel(model)
        else { return }
        
        likeCache.setObject(cacheModel, forKey: model.id as NSString)
    }
    
    func conversation(_ model: ConversationModel) {
        guard model.id.count > 0,
              let cacheModel = ConversationCacheModel(model)
        else { return }
        
        conversationCache.setObject(cacheModel, forKey: model.id as NSString)
    }
    
    func message(_ model: MessageModel) {
        guard model.id.count > 0,
              let cacheModel = MessageCacheModel(model)
        else { return }
        
        messageCache.setObject(cacheModel, forKey: model.id as NSString)
    }
   
}
