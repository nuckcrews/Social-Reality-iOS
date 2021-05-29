//
//  DeleteMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation

struct DeleteMethods {
    
    func user(_ id: String, completion: @escaping(_ result: ResultType) -> Void) {
        Cache.delete.user(id)
        Remote.delete.user(id) { result in
            completion(result)
        }
    }
    
    func creation(_ id: String, completion: @escaping(_ result: ResultType) -> Void) {
        Cache.delete.creation(id)
        Remote.delete.creation(id) { result in
            completion(result)
        }
    }
    
    func comment(_ id: String, completion: @escaping(_ result: ResultType) -> Void) {
        Cache.delete.comment(id)
        Remote.delete.comment(id) { result in
            completion(result)
        }
    }
    
    func like(_ id: String, completion: @escaping(_ result: ResultType) -> Void) {
        Cache.delete.like(id)
        Remote.delete.like(id) { result in
            completion(result)
        }
    }
    
    func conversation(_ id: String, completion: @escaping(_ result: ResultType) -> Void) {
        Cache.delete.conversation(id)
        Remote.delete.conversation(id) { result in
            completion(result)
        }
    }
    
    func message(conversationID: String, id: String, completion: @escaping(_ result: ResultType) -> Void) {
        Cache.delete.message(id)
        Remote.delete.message(conversationID: conversationID, id: id) { result in
            completion(result)
        }
    }
    
}
