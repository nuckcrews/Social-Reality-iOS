//
//  UpdateMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation

struct UpdateMethods {
    
    func user(_ id: String, data: [String: Any], cache: Bool = true, completion: @escaping (ResultType) -> Void) {
        guard id.count > 0 else { completion(.error); return }
        
        if cache {
            Query.cache.update.user(id, data: data)
        }
        
        Query.remote.update.user(id, data: data) { result in
            completion(result)
        }
        
    }
    
    func creation(_ id: String, data: [String: Any], cache: Bool = true, completion: @escaping (ResultType) -> Void) {
        guard id.count > 0 else { completion(.error); return }

        if cache {
            Query.cache.update.creation(id, data: data)
        }
        
        Query.remote.update.creation(id, data: data) { result in
            completion(result)
        }
        
    }
    
    func comment(_ id: String, data: [String: Any], cache: Bool = true, completion: @escaping (ResultType) -> Void) {
        guard id.count > 0 else { completion(.error); return }

        if cache {
            Query.cache.update.comment(id, data: data)
        }
        
        Query.remote.update.comment(id, data: data) { result in
            completion(result)
        }
        
    }
    
    func like(_ id: String, data: [String: Any], cache: Bool = true, completion: @escaping (ResultType) -> Void) {
        guard id.count > 0 else { completion(.error); return }

        if cache {
            Query.cache.update.like(id, data: data)
        }
        
        Query.remote.update.like(id, data: data) { result in
            completion(result)
        }
        
    }
    
    func message(conversationID: String, id: String, data: [String: Any], cache: Bool = true, completion: @escaping (ResultType) -> Void) {
        guard conversationID.count > 0, id.count > 0 else { completion(.error); return }

        if cache {
            Query.cache.update.message(id, data: data)
        }
        
        Query.remote.update.message(conversationID: conversationID, id: id, data: data) { result in
            completion(result)
        }
        
    }
    
    func conversation(_ id: String, data: [String: Any], cache: Bool = true, completion: @escaping (ResultType) -> Void) {
        guard id.count > 0 else { completion(.error); return }

        if cache {
            Query.cache.update.conversation(id, data: data)
        }
        
        Query.remote.update.conversation(id, data: data) { result in
            completion(result)
        }
        
    }
    
}
