//
//  ReadMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Firebase
import CodableFirebase

// MARK: Read Query Methods - Local

struct ReadMethods {
    
    private let db = Firestore.firestore().collection(Environment.dbs).document(Environment.env)
    
    func user(id: String, completion: @escaping(_ result: UserModel?) -> Void) {
        db.collection(Collections.users.rawValue).document(id).getDocument { snapshot, error in
            if error != nil || snapshot == nil {
                completion(nil)
            } else {
                if let data = snapshot?.data() {
                    do {
                        let model = try FirestoreDecoder().decode(UserModel.self, from: data)
                        print("Model: \(model)")
                        completion(model)
                    } catch {
                        completion(nil)
                    }
                } else {
                    print("Document does not exist")
                    completion(nil)
                }
            }
        }
    }
    
    func creation(id: String, completion: @escaping(_ result: CreationModel?) -> Void) {
        db.collection(Collections.creations.rawValue).document(id).getDocument { snapshot, error in
            if error != nil || snapshot == nil {
                completion(nil)
            } else {
                if let data = snapshot?.data() {
                    do {
                        let model = try FirestoreDecoder().decode(CreationModel.self, from: data)
                        print("Model: \(model)")
                        completion(model)
                    } catch {
                        completion(nil)
                    }
                } else {
                    print("Document does not exist")
                    completion(nil)
                }
            }
        }
    }
    
    func comment(id: String, completion: @escaping(_ result: CommentModel?) -> Void) {
        db.collection(Collections.comments.rawValue).document(id).getDocument { snapshot, error in
            if error != nil || snapshot == nil {
                completion(nil)
            } else {
                if let data = snapshot?.data() {
                    do {
                        let model = try FirestoreDecoder().decode(CommentModel.self, from: data)
                        print("Model: \(model)")
                        completion(model)
                    } catch {
                        completion(nil)
                    }
                } else {
                    print("Document does not exist")
                    completion(nil)
                }
            }
        }
    }
    
    func like(id: String, completion: @escaping(_ result: LikeModel?) -> Void) {
        db.collection(Collections.likes.rawValue).document(id).getDocument { snapshot, error in
            if error != nil || snapshot == nil {
                completion(nil)
            } else {
                if let data = snapshot?.data() {
                    do {
                        let model = try FirestoreDecoder().decode(LikeModel.self, from: data)
                        print("Model: \(model)")
                        completion(model)
                    } catch {
                        completion(nil)
                    }
                } else {
                    print("Document does not exist")
                    completion(nil)
                }
            }
        }
    }
    
    func users(completion: @escaping(_ result: [UserModel]?) -> Void) {
        db.collection(Collections.users.rawValue).getDocuments { snapshot, error in
            if error != nil || snapshot == nil {
                completion(nil)
            } else {
                if let docs = snapshot?.documents {
                    do {
                        var models = [UserModel]()
                        try docs.forEach { doc in
                            let model = try FirestoreDecoder().decode(UserModel.self, from: doc.data())
                            models.append(model)
                        }
                        completion(models)
                    } catch {
                        completion(nil)
                    }
                } else {
                    print("Document does not exist")
                    completion(nil)
                }
            }
        }
    }
    
    func usersWithPredicate(field: String, value: String, completion: @escaping(_ result: [UserModel]?) -> Void) {
        db.collection(Collections.users.rawValue).whereField(field, isEqualTo: value).getDocuments { snapshot, error in
            if error != nil || snapshot == nil {
                completion(nil)
            } else {
                if let docs = snapshot?.documents {
                    do {
                        var models = [UserModel]()
                        try docs.forEach { doc in
                            let model = try FirestoreDecoder().decode(UserModel.self, from: doc.data())
                            models.append(model)
                        }
                        completion(models)
                    } catch {
                        completion(nil)
                    }
                } else {
                    print("Document does not exist")
                    completion(nil)
                }
            }
        }
    }
    
    func userCreations(id: String, completion: @escaping(_ result: [CreationModel]?) -> Void) {

    }
    
    func userLikes(id: String, completion: @escaping(_ result: [LikeModel]?) -> Void) {

    }
    
    func userComments(id: String, completion: @escaping(_ result: [CommentModel]?) -> Void) {

    }
    
    func creationComments(id: String, completion: @escaping(_ result: [CommentModel]?) -> Void) {

    }
    
    func creationLikes(id: String, completion: @escaping(_ result: [LikeModel]?) -> Void) {

    }
    
}
