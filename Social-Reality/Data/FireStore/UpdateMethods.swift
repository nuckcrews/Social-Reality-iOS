//
//  UpdateMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Firebase

// MARK: Update Query Methods - Local

struct UpdateMethods {
    
    private let db = Firestore.firestore().collection(Environment.dbs).document(Environment.env)
    
    func user(id: String, data: [String: Any], completion: @escaping(_ result: ResultType) -> Void) {
        db.collection(Collections.users.rawValue).document(id).setData(data, merge: true) { error in
            if error != nil {
                completion(.error)
            } else {
                completion(.success)
            }
        }
        
    }
    
    func creation(id: String, data: [String: Any], completion: @escaping(_ result: ResultType) -> Void) {
        db.collection(Collections.creations.rawValue).document(id).setData(data, merge: true) { error in
            if error != nil {
                completion(.error)
            } else {
                completion(.success)
            }
        }

    }
    
    func comment(id: String, data: [String: Any], completion: @escaping(_ result: ResultType) -> Void) {
        db.collection(Collections.comments.rawValue).document(id).setData(data, merge: true) { error in
            if error != nil {
                completion(.error)
            } else {
                completion(.success)
            }
        }

    }
    
    func like(id: String, data: [String: Any], completion: @escaping(_ result: ResultType) -> Void) {
        db.collection(Collections.likes.rawValue).document(id).setData(data, merge: true) { error in
            if error != nil {
                completion(.error)
            } else {
                completion(.success)
            }
        }

    }
    
}
