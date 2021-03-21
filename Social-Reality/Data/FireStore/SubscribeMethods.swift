//
//  SubscribeMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Firebase
import CodableFirebase

// MARK: Subscribe Query Methods - Local

struct SubscribeMethods {
    
    private let db = Firestore.firestore().collection(Environment.dbs).document(Environment.env)
    
    func user(id: String, completion: @escaping(_ result: UserModel?) -> Void) {
        db.collection(Collections.users.rawValue).document(id).addSnapshotListener(includeMetadataChanges: true, listener: { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                completion(nil)
                return
            }
            if let data = snapshot.data() {
                do {
                    let model = try FirestoreDecoder().decode(UserModel.self, from: data)
                    completion(model)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        })
    }
    
    func creation(id: String, completion: @escaping(_ result: CreationModel?) -> Void) {
        db.collection(Collections.creations.rawValue).document(id).addSnapshotListener(includeMetadataChanges: true, listener: { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                completion(nil)
                return
            }
            if let data = snapshot.data() {
                do {
                    let model = try FirestoreDecoder().decode(CreationModel.self, from: data)
                    completion(model)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        })
    }
    
    func comment(id: String, completion: @escaping(_ result: CommentModel?) -> Void) {
        db.collection(Collections.comments.rawValue).document(id).addSnapshotListener(includeMetadataChanges: true, listener: { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                completion(nil)
                return
            }
            if let data = snapshot.data() {
                do {
                    let model = try FirestoreDecoder().decode(CommentModel.self, from: data)
                    completion(model)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        })
    }
    
    func like(id: String, completion: @escaping(_ result: LikeModel?) -> Void) {
        db.collection(Collections.likes.rawValue).document(id).addSnapshotListener(includeMetadataChanges: true, listener: { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                completion(nil)
                return
            }
            if let data = snapshot.data() {
                do {
                    let model = try FirestoreDecoder().decode(LikeModel.self, from: data)
                    completion(model)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        })
    }
    
    func users(id: String, completion: @escaping(_ result: [UserModel]?, _ type: EventType?) -> Void) {
        db.collection(Collections.users.rawValue).addSnapshotListener(includeMetadataChanges: false, listener: { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                completion(nil, nil)
                return
            }
            var models = [UserModel]()
            snapshot.documents.forEach({ doc in
                do {
                    let model = try FirestoreDecoder().decode(UserModel.self, from: doc.data())
                    models.append(model)
                } catch {
                    print("doc error")
                }
            })
        })
    }
    
    func creations(id: String, completion: @escaping(_ result: [CreationModel]?) -> Void) {
        db.collection(Collections.creations.rawValue).addSnapshotListener(includeMetadataChanges: false, listener: { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                completion(nil)
                return
            }
            var models = [CreationModel]()
            snapshot.documents.forEach({ doc in
                do {
                    let model = try FirestoreDecoder().decode(CreationModel.self, from: doc.data())
                    models.append(model)
                } catch {
                    print("doc error")
                }
            })
            completion(models)
        })
    }
    
    func comments(id: String, completion: @escaping(_ result: [CommentModel]?) -> Void) {
        db.collection(Collections.comments.rawValue).addSnapshotListener(includeMetadataChanges: false, listener: { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                completion(nil)
                return
            }
            var models = [CommentModel]()
            snapshot.documents.forEach({ doc in
                do {
                    let model = try FirestoreDecoder().decode(CommentModel.self, from: doc.data())
                    models.append(model)
                } catch {
                    print("doc error")
                }
            })
            completion(models)
        })
    }
    
    func likes(id: String, completion: @escaping(_ result: [LikeModel]?) -> Void) {
        db.collection(Collections.likes.rawValue).addSnapshotListener(includeMetadataChanges: false, listener: { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                completion(nil)
                return
            }
            var models = [LikeModel]()
            snapshot.documents.forEach({ doc in
                do {
                    let model = try FirestoreDecoder().decode(LikeModel.self, from: doc.data())
                    models.append(model)
                } catch {
                    print("doc error")
                }
            })
            completion(models)
        })
        
    }
    
}
