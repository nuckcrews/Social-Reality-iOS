//
//  DeleteMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Firebase

// MARK: Delete Query Methods - Local

struct DeleteMethods {
    
    private let db = Firestore.firestore().collection(Environment.dbs).document(Environment.env)
    
    func user(_ id: String, completion: @escaping(_ result: ResultType) -> Void) {
        db.collection(Collections.users.rawValue).document(id).delete()
    }
    
    func creation(_ id: String, completion: @escaping(_ result: ResultType) -> Void) {
        db.collection(Collections.creations.rawValue).document(id).delete()
    }
    
    func comment(_ id: String, completion: @escaping(_ result: ResultType) -> Void) {
        db.collection(Collections.comments.rawValue).document(id).delete()
    }
    
    func like(_ id: String, completion: @escaping(_ result: ResultType) -> Void) {
        db.collection(Collections.likes.rawValue).document(id).delete()
    }
    
    func message(conversationID: String, id: String, completion: @escaping(_ result: ResultType) -> Void) {
        db.collection(Collections.conversations.rawValue).document(conversationID)
            .collection(Collections.likes.rawValue).document(id).delete()
    }
    
    func conversation(_ id: String, completion: @escaping(_ result: ResultType) -> Void) {
        db.collection(Collections.conversations.rawValue).document(id).delete()
    }
    
}
