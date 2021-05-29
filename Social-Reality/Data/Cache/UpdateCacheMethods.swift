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
    
    func user(_ id: String ,data: [String: Any], cache: Bool = false, completion: @escaping(_ result: ResultType) -> Void) {
        guard data.count > 0 else { completion(.error); return }
        
        if cache {
            if let model = userCache.object(forKey: id)?.user {
                
            }
        }
        
    }
    
}
