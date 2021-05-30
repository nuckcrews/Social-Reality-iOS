//
//  ReadMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation

struct ReadMethods {
    
    func user(_ id: String, cache: Bool = true, completion: @escaping(_ result: UserModel?) -> Void) {
        
        guard id.count > 0 else { completion(nil); return }
        
        let cacheModel = Query.cache.get.user(id)
        if cache, let cacheModel = cacheModel {
            completion(cacheModel)
        }
        
        Query.remote.get.user(id) { remoteModel in
            guard let remoteModel = remoteModel else {
                if cache && cacheModel == nil {
                    completion(nil)
                }
                return
            }
            if !cache {
                completion(remoteModel)
            } else if cacheModel != remoteModel {
                Query.cache.write.user(remoteModel)
                completion(remoteModel)
            }
        }
        
    }
    
    func creation(_ id: String, cache: Bool = true, completion: @escaping(_ result: CreationModel?) -> Void) {
        
        guard id.count > 0 else { completion(nil); return }
        
        let cacheModel = Query.cache.get.creation(id)
        if cache, let cacheModel = cacheModel {
            completion(cacheModel)
        }
        
        Query.remote.get.creation(id) { remoteModel in
            guard let remoteModel = remoteModel else {
                if cache && cacheModel == nil {
                    completion(nil)
                }
                return
            }
            if !cache {
                completion(remoteModel)
            } else if cacheModel != remoteModel {
                Query.cache.write.creation(remoteModel)
                completion(remoteModel)
            }
        }
        
    }
    
    func comment(_ id: String, cache: Bool = true, completion: @escaping(_ result: CommentModel?) -> Void) {
        
        guard id.count > 0 else { completion(nil); return }
        
        let cacheModel = Query.cache.get.comment(id)
        if cache, let cacheModel = cacheModel {
            completion(cacheModel)
        }
        
        Query.remote.get.comment(id) { remoteModel in
            guard let remoteModel = remoteModel else {
                if cache && cacheModel == nil {
                    completion(nil)
                }
                return
            }
            if !cache {
                completion(remoteModel)
            } else if cacheModel != remoteModel {
                Query.cache.write.comment(remoteModel)
                completion(remoteModel)
            }
        }
        
    }
    
    func like(_ id: String, cache: Bool = true, completion: @escaping(_ result: LikeModel?) -> Void) {
        
        guard id.count > 0 else { completion(nil); return }
        
        let cacheModel = Query.cache.get.like(id)
        if cache, let cacheModel = cacheModel {
            completion(cacheModel)
        }
        
        Query.remote.get.like(id) { remoteModel in
            guard let remoteModel = remoteModel else {
                if cache && cacheModel == nil {
                    completion(nil)
                }
                return
            }
            if !cache {
                completion(remoteModel)
            } else if cacheModel != remoteModel {
                Query.cache.write.like(remoteModel)
                completion(remoteModel)
            }
        }
        
    }
    
    func conversation(_ id: String, cache: Bool = true, completion: @escaping(_ result: ConversationModel?) -> Void) {
        
        guard id.count > 0 else { completion(nil); return }
        
        let cacheModel = Query.cache.get.conversation(id)
        if cache, let cacheModel = cacheModel {
            completion(cacheModel)
        }
        
        Query.remote.get.conversation(id) { remoteModel in
            guard let remoteModel = remoteModel else {
                if cache && cacheModel == nil {
                    completion(nil)
                }
                return
            }
            if !cache {
                completion(remoteModel)
            } else if cacheModel != remoteModel {
                Query.cache.write.conversation(remoteModel)
                completion(remoteModel)
            }
        }
        
    }
    
    func message(_ id: String, conversationID: String, cache: Bool = true, completion: @escaping(_ result: MessageModel?) -> Void) {
        
        guard id.count > 0 else { completion(nil); return }
        
        let cacheModel = Query.cache.get.message(id)
        if cache, let cacheModel = cacheModel {
            completion(cacheModel)
        }
        
        Query.remote.get.message(id, conversationID: id) { remoteModel in
            guard let remoteModel = remoteModel else {
                if cache && cacheModel == nil {
                    completion(nil)
                }
                return
            }
            if !cache {
                completion(remoteModel)
            } else if cacheModel != remoteModel {
                Query.cache.write.message(remoteModel)
                completion(remoteModel)
            }
        }
        
    }
    
}
