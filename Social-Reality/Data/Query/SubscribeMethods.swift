//
//  SubscribeMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation
import Firebase

struct SubscribeMethods {
    
    func user(_ id: String, cache: Bool = true, completion: @escaping(_ result: UserModel?, _ listener: ListenerRegistration?) -> Void) {
        
        guard id.count > 0 else { completion(nil, nil); return }
        
        var cacheModel = Query.cache.get.user(id)
        if cache, let cacheModel = cacheModel {
            completion(cacheModel, nil)
        }
        
        Query.remote.subscribe.user(id) { remoteModel, lstn in
            guard let remoteModel = remoteModel else {
                if cache && cacheModel == nil {
                    completion(nil, nil)
                }
                return
            }
            
            if !cache {
                completion(remoteModel, lstn)
            } else if cacheModel != remoteModel {
                Query.cache.write.user(remoteModel)
                cacheModel = remoteModel
                completion(remoteModel, lstn)
            }
        }
        
    }
    
    func creation(_ id: String, cache: Bool = true, completion: @escaping(_ result: CreationModel?, _ listener: ListenerRegistration?) -> Void) {
        
        guard id.count > 0 else { completion(nil, nil); return }
        
        var cacheModel = Query.cache.get.creation(id)
        if cache, let cacheModel = cacheModel {
            completion(cacheModel, nil)
        }
        
        Query.remote.subscribe.creation(id) { remoteModel, lstn in
            guard let remoteModel = remoteModel else {
                if cache && cacheModel == nil {
                    completion(nil, nil)
                }
                return
            }
            
            if !cache {
                completion(remoteModel, lstn)
            } else if cacheModel != remoteModel {
                Query.cache.write.creation(remoteModel)
                cacheModel = remoteModel
                completion(remoteModel, lstn)
            }
        }
        
    }
    
    func comment(_ id: String, cache: Bool = true, completion: @escaping(_ result: CommentModel?, _ listener: ListenerRegistration?) -> Void) {
        
        guard id.count > 0 else { completion(nil, nil); return }
        
        var cacheModel = Query.cache.get.comment(id)
        if cache, let cacheModel = cacheModel {
            completion(cacheModel, nil)
        }
        
        Query.remote.subscribe.comment(id) { remoteModel, lstn in
            guard let remoteModel = remoteModel else {
                if cache && cacheModel == nil {
                    completion(nil, nil)
                }
                return
            }
            
            if !cache {
                completion(remoteModel, lstn)
            } else if cacheModel != remoteModel {
                Query.cache.write.comment(remoteModel)
                cacheModel = remoteModel
                completion(remoteModel, lstn)
            }
        }
        
    }
    
    func like(_ id: String, cache: Bool = true, completion: @escaping(_ result: LikeModel?, _ listener: ListenerRegistration?) -> Void) {
        
        guard id.count > 0 else { completion(nil, nil); return }
        
        var cacheModel = Query.cache.get.like(id)
        if cache, let cacheModel = cacheModel {
            completion(cacheModel, nil)
        }
        
        Query.remote.subscribe.like(id) { remoteModel, lstn in
            guard let remoteModel = remoteModel else {
                if cache && cacheModel == nil {
                    completion(nil, nil)
                }
                return
            }
            
            if !cache {
                completion(remoteModel, lstn)
            } else if cacheModel != remoteModel {
                Query.cache.write.like(remoteModel)
                cacheModel = remoteModel
                completion(remoteModel, lstn)
            }
        }
        
    }
    
}
