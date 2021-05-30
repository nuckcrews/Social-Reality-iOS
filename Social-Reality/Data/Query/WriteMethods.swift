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
            Query.cache.write.user(model)
        }
        
        Query.remote.write.user(model) { result in
            completion(result)
        }
        
    }
    
    func creation(model: CreationModel, cache: Bool = true, completion: @escaping(_ result: ResultType) -> Void) {
        
        if cache {
            Query.cache.write.creation(model)
        }
        
        Query.remote.write.creation(model) { result in
            completion(result)
        }
        
    }
    
    func comment(model: CommentModel, cache: Bool = true, completion: @escaping(_ result: ResultType) -> Void) {
        
        if cache {
            Query.cache.write.comment(model)
        }
        
        Query.remote.write.comment(model) { result in
            completion(result)
        }
        
    }
    
    func like(model: LikeModel, cache: Bool = true, completion: @escaping(_ result: ResultType) -> Void) {
        
        if cache {
            Query.cache.write.like(model)
        }
        
        Query.remote.write.like(model) { result in
            completion(result)
        }
        
    }
    
    func conversation(model: ConversationModel, cache: Bool = true, completion: @escaping(_ result: ResultType) -> Void) {
        
        if cache {
            Query.cache.write.conversation(model)
        }
        
        Query.remote.write.conversation(model) { result in
            completion(result)
        }
        
    }
    
    func message(model: MessageModel, cache: Bool = true, completion: @escaping(_ result: ResultType) -> Void) {
        
        if cache {
            Query.cache.write.message(model)
        }
        
        Query.remote.write.message(model) { result in
            completion(result)
        }
        
    }
    
}