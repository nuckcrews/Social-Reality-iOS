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
        
        if cache, let model = Cache.get.user(id) {
            completion(model)
            return
        }
        
        Remote.get.user(id) { model in
            guard let model = model else { completion(nil); return }
            Cache.write.user(model)
            completion(model)
        }
        
    }
    
    func creation(_ id: String, cache: Bool = true, completion: @escaping(_ result: CreationModel?) -> Void) {
        
        guard id.count > 0 else { completion(nil); return }
        
        if cache, let model = Cache.get.creation(id) {
            completion(model)
            return
        }
        
        Remote.get.creation(id) { model in
            guard let model = model else { completion(nil); return }
            Cache.write.creation(model)
            completion(model)
        }
        
    }
    
    func comment(_ id: String, cache: Bool = true, completion: @escaping(_ result: CommentModel?) -> Void) {
        
        guard id.count > 0 else { completion(nil); return }
        
        if cache, let model = Cache.get.comment(id) {
            completion(model)
            return
        }
        
        Remote.get.comment(id) { model in
            guard let model = model else { completion(nil); return }
            Cache.write.comment(model)
            completion(model)
        }
        
    }
    
    func like(_ id: String, cache: Bool = true, completion: @escaping(_ result: LikeModel?) -> Void) {
        
        guard id.count > 0 else { completion(nil); return }
        
        if cache, let model = Cache.get.like(id) {
            completion(model)
            return
        }
        
        Remote.get.like(id) { model in
            guard let model = model else { completion(nil); return }
            Cache.write.like(model)
            completion(model)
        }
        
    }
    
    func conversation(_ id: String, cache: Bool = true, completion: @escaping(_ result: ConversationModel?) -> Void) {
        
        guard id.count > 0 else { completion(nil); return }
        
        if cache, let model = Cache.get.conversation(id) {
            completion(model)
            return
        }
        
        Remote.get.conversation(id) { model in
            guard let model = model else { completion(nil); return }
            Cache.write.conversation(model)
            completion(model)
        }
        
    }
    
    func message(_ id: String, conversationID: String, cache: Bool = true, completion: @escaping(_ result: MessageModel?) -> Void) {
        
        guard id.count > 0 else { completion(nil); return }
        
        if cache, let model = Cache.get.message(id) {
            completion(model)
            return
        }
        
        Remote.get.message(id, conversationID: conversationID) { model in
            guard let model = model else { completion(nil); return }
            Cache.write.message(model)
            completion(model)
        }
        
    }
    
}
