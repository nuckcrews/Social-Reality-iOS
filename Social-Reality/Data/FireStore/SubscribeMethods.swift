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
    
    func user(id: String, completion: @escaping(_ result: UserModel?, _ listener: ListenerRegistration?) -> Void) {
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.users.rawValue).document(id)
            .addSnapshotListener(includeMetadataChanges: true, listener: { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(nil, nil)
                    return
                }
                if let data = snapshot.data() {
                    do {
                        let model = try FirestoreDecoder().decode(UserModel.self, from: data)
                        completion(model, lstn)
                    } catch {
                        completion(nil, nil)
                    }
                } else {
                    completion(nil, nil)
                }
            })
    }
    
    func creation(id: String, completion: @escaping(_ result: CreationModel?, _ listener: ListenerRegistration?) -> Void) {
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.creations.rawValue).document(id)
            .addSnapshotListener(includeMetadataChanges: true, listener: { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(nil, nil)
                    return
                }
                if let data = snapshot.data() {
                    do {
                        let model = try FirestoreDecoder().decode(CreationModel.self, from: data)
                        completion(model, lstn)
                    } catch {
                        completion(nil, nil)
                    }
                } else {
                    completion(nil, nil)
                }
            })
    }
    
    func comment(id: String, completion: @escaping(_ result: CommentModel?, _ listener: ListenerRegistration?) -> Void) {
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.comments.rawValue).document(id)
            .addSnapshotListener(includeMetadataChanges: true, listener: { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(nil, nil)
                    return
                }
                if let data = snapshot.data() {
                    do {
                        let model = try FirestoreDecoder().decode(CommentModel.self, from: data)
                        completion(model, lstn)
                    } catch {
                        completion(nil, nil)
                    }
                } else {
                    completion(nil, nil)
                }
            })
    }
    
    func like(id: String, completion: @escaping(_ result: LikeModel?, _ listener: ListenerRegistration?) -> Void) {
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.likes.rawValue).document(id)
            .addSnapshotListener(includeMetadataChanges: true, listener: { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(nil, nil)
                    return
                }
                if let data = snapshot.data() {
                    do {
                        let model = try FirestoreDecoder().decode(LikeModel.self, from: data)
                        completion(model, lstn)
                    } catch {
                        completion(nil, nil)
                    }
                } else {
                    completion(nil, nil)
                }
            })
    }
    
    func users(completion: @escaping(_ result: [UserModel]?, _ listener: ListenerRegistration?) -> Void) {
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.users.rawValue)
            .addSnapshotListener(includeMetadataChanges: false, listener: { snapshot, error in
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
                completion(models, lstn)
            })
    }
    
    func creations(completion: @escaping(_ result: [CreationModel]?, _ listener: ListenerRegistration?) -> Void) {
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.creations.rawValue)
            .addSnapshotListener(includeMetadataChanges: false, listener: { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(nil, nil)
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
                completion(models, lstn)
            })
    }
    
    func comments(completion: @escaping(_ result: [CommentModel]?, _ listener: ListenerRegistration?) -> Void) {
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.comments.rawValue)
            .addSnapshotListener(includeMetadataChanges: false, listener: { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(nil, nil)
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
                completion(models, lstn)
            })
    }
    
    func likes(completion: @escaping(_ result: [LikeModel]?, _ listener: ListenerRegistration?) -> Void) {
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.likes.rawValue)
            .addSnapshotListener(includeMetadataChanges: false, listener: { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(nil, nil)
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
                completion(models, lstn)
            })
    }
    
    func usersWithPredicate(field: String, value: String, completion: @escaping(_ result: [UserModel]?, _ listener: ListenerRegistration?) -> Void) {
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.users.rawValue)
            .whereField(field, isEqualTo: value)
            .addSnapshotListener(includeMetadataChanges: false, listener: { snapshot, error in
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
                completion(models, lstn)
            })
    }
    
    func creationsWithPredicate(field: String, value: String, completion: @escaping(_ result: [CreationModel]?, _ listener: ListenerRegistration?) -> Void) {
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.creations.rawValue)
            .whereField(field, isEqualTo: value)
            .addSnapshotListener(includeMetadataChanges: false, listener: { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(nil, nil)
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
                completion(models, lstn)
            })
    }
    
    func commentsWithPredicate(field: String, value: String, completion: @escaping(_ result: [CommentModel]?, _ listener: ListenerRegistration?) -> Void) {
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.comments.rawValue)
            .whereField(field, isEqualTo: value)
            .addSnapshotListener(includeMetadataChanges: false, listener: { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(nil, nil)
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
                completion(models, lstn)
            })
    }
    
    func likesWithPredicate(field: String, value: String, completion: @escaping(_ result: [LikeModel]?, _ listener: ListenerRegistration?) -> Void) {
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.likes.rawValue)
            .whereField(field, isEqualTo: value)
            .addSnapshotListener(includeMetadataChanges: false, listener: { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(nil, nil)
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
                completion(models, lstn)
            })
    }
}
