//
//  DeleteMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation

struct DeleteMethods {
    
    func user(_ id: String, completion: @escaping (ResultType) -> Void) {
        Query.cache.delete.user(id)
        Query.remote.delete.user(id) { result in
            completion(result)
        }
    }
    
    func creation(_ id: String, completion: @escaping (ResultType) -> Void) {
        Query.cache.delete.creation(id)
        Query.remote.delete.creation(id) { result in
            completion(result)
        }
    }
    
    func comment(_ id: String, completion: @escaping (ResultType) -> Void) {
        Query.cache.delete.comment(id)
        Query.remote.delete.comment(id) { result in
            completion(result)
        }
    }
    
    func like(_ id: String, completion: @escaping (ResultType) -> Void) {
        Query.cache.delete.like(id)
        Query.remote.delete.like(id) { result in
            completion(result)
        }
    }
    
    func conversation(_ id: String, completion: @escaping (ResultType) -> Void) {
        Query.cache.delete.conversation(id)
        Query.remote.delete.conversation(id) { result in
            completion(result)
        }
    }
    
    func message(conversationID: String, id: String, completion: @escaping (ResultType) -> Void) {
        Query.cache.delete.message(id)
        Query.remote.delete.message(conversationID: conversationID, id: id) { result in
            completion(result)
        }
    }
    
}
