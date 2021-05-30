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
        
        Remote.subscribe.user(id: id) { remoteModel, lstn in
            guard let remoteModel = remoteModel else {
                if cache && cacheModel == nil {
                    completion(nil, nil)
                }
                return
            }
            
            if !cache {
                completion(remoteModel, lstn)
            } else if cacheModel != remoteModel {
                Cache.write.user(remoteModel)
                cacheModel = remoteModel
                completion(remoteModel, lstn)
            }
            
        }
        
    }
    
}
