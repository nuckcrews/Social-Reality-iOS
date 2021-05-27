//
//  UpdateRemoteMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Firebase

// MARK: Update Remote Query Methods - Local

struct UpdateRemoteMethods {
    
    private let db = Firestore.firestore().collection(Environment.dbs).document(Environment.env)
    
    func user(id: String, data: [String: Any], completion: @escaping(_ result: ResultType) -> Void) {
        guard id.count > 0 else { completion(.error); return }
        db.collection(Collections.users.rawValue).document(id).setData(data, merge: true) { error in
            if error != nil {
                completion(.error)
            } else {
                completion(.success)
            }
        }
    }
    
    func creation(id: String, data: [String: Any], completion: @escaping(_ result: ResultType) -> Void) {
        guard id.count > 0 else { completion(.error); return }
        db.collection(Collections.creations.rawValue).document(id).setData(data, merge: true) { error in
            if error != nil {
                completion(.error)
            } else {
                completion(.success)
            }
        }
    }
    
    func comment(id: String, data: [String: Any], completion: @escaping(_ result: ResultType) -> Void) {
        guard id.count > 0 else { completion(.error); return }
        db.collection(Collections.comments.rawValue).document(id).setData(data, merge: true) { error in
            if error != nil {
                completion(.error)
            } else {
                completion(.success)
            }
        }
    }
    
    func like(id: String, data: [String: Any], completion: @escaping(_ result: ResultType) -> Void) {
        guard id.count > 0 else { completion(.error); return }
        db.collection(Collections.likes.rawValue).document(id).setData(data, merge: true) { error in
            if error != nil {
                completion(.error)
            } else {
                completion(.success)
            }
        }
    }
    
    func message(conversationID: String, id: String, data: [String: Any], completion: @escaping(_ result: ResultType) -> Void) {
        guard conversationID.count > 0, id.count > 0 else { completion(.error); return }
        db.collection(Collections.conversations.rawValue)
            .document(conversationID).collection(Collections.messages.rawValue)
            .document(id).setData(data, merge: true) { error in
                if error != nil {
                    completion(.error)
                } else {
                    completion(.success)
                }
            }
    }
    
    func conversation(id: String, data: [String: Any], completion: @escaping(_ result: ResultType) -> Void) {
        guard id.count > 0 else { completion(.error); return }
        db.collection(Collections.conversations.rawValue)
            .document(id).setData(data, merge: true) { error in
                if error != nil {
                    completion(.error)
                } else {
                    completion(.success)
                }
            }
    }
    
}
