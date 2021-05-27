//
//  WriteMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation

struct WriteMethods {
    
    func user(model: UserModel, cache: Bool = true, completion: @escaping(_ result: ResultType) -> Void) {
        
        if cache {
            Cache.write.user(model)
        }
        
        Remote.write.user(model) { result in
            completion(result)
        }
        
    }
    
    func creation(model: CreationModel, cache: Bool = true, completion: @escaping(_ result: ResultType) -> Void) {
        
        if cache {
            Cache.write.creation(model)
        }
        
        Remote.write.creation(model) { result in
            completion(result)
        }
        
    }
    
    func comment(model: CommentModel, cache: Bool = true, completion: @escaping(_ result: ResultType) -> Void) {
        
        if cache {
            Cache.write.comment(model)
        }
        
        Remote.write.comment(model) { result in
            completion(result)
        }
        
    }
    
    func like(model: LikeModel, cache: Bool = true, completion: @escaping(_ result: ResultType) -> Void) {
        
        if cache {
            Cache.write.like(model)
        }
        
        Remote.write.like(model) { result in
            completion(result)
        }
        
    }
    
    func conversation(model: ConversationModel, cache: Bool = true, completion: @escaping(_ result: ResultType) -> Void) {
        
        if cache {
            Cache.write.conversation(model)
        }
        
        Remote.write.conversation(model) { result in
            completion(result)
        }
        
    }
    
    func message(model: MessageModel, cache: Bool = true, completion: @escaping(_ result: ResultType) -> Void) {
        
        if cache {
            Cache.write.message(model)
        }
        
        Remote.write.message(model) { result in
            completion(result)
        }
        
    }
    
}
