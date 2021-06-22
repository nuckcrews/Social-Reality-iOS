//
//  DeleteRemoteMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Firebase

// MARK: Delete Remote Query Methods - Local

struct DeleteRemoteMethods {
    
    private let db = Firestore.firestore().collection(Environment.dbs).document(Environment.env)
    
    func user(_ id: String, completion: @escaping (ResultType) -> Void) {
        guard id.count > 0 else { completion(.error); return }
        db.collection(Collections.users.rawValue).document(id).delete { error in
            if error != nil {
                completion(.error)
            } else {
                completion(.success)
            }
        }
    }
    
    func creation(_ id: String, completion: @escaping (ResultType) -> Void) {
        guard id.count > 0 else { completion(.error); return }
        db.collection(Collections.creations.rawValue).document(id).delete { error in
            if error != nil {
                completion(.error)
            } else {
                completion(.success)
            }
        }
    }
    
    func comment(_ id: String, completion: @escaping (ResultType) -> Void) {
        guard id.count > 0 else { completion(.error); return }
        db.collection(Collections.comments.rawValue).document(id).delete { error in
            if error != nil {
                completion(.error)
            } else {
                completion(.success)
            }
        }
    }
    
    func like(_ id: String, completion: @escaping (ResultType) -> Void) {
        guard id.count > 0 else { completion(.error); return }
        db.collection(Collections.likes.rawValue).document(id).delete { error in
            if error != nil {
                completion(.error)
            } else {
                completion(.success)
            }
        }
    }
    
    func userLike(userID: String, id: String, completion: @escaping (ResultType) -> Void) {
        guard id.count > 0, userID.count > 0 else { completion(.error); return }
        db.collection(Collections.users.rawValue)
            .document(userID)
            .collection(Collections.likes.rawValue)
            .document(id).delete { error in
            if error != nil {
                completion(.error)
            } else {
                completion(.success)
            }
        }
    }
    
    func message(conversationID: String, id: String, completion: @escaping (ResultType) -> Void) {
        guard id.count > 0, conversationID.count > 0 else { completion(.error); return }
        db.collection(Collections.conversations.rawValue).document(conversationID)
            .collection(Collections.likes.rawValue).document(id).delete { error in
                if error != nil {
                    completion(.error)
                } else {
                    completion(.success)
                }
            }
    }
    
    func conversation(_ id: String, completion: @escaping (ResultType) -> Void) {
        guard id.count > 0 else { completion(.error); return }
        db.collection(Collections.conversations.rawValue).document(id).delete { error in
            if error != nil {
                completion(.error)
            } else {
                completion(.success)
            }
        }
    }
    
}
