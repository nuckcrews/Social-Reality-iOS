//
//  SubscribeRemoteMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Firebase
import CodableFirebase

// MARK: Subscribe Remote Query Methods - Local

struct SubscribeRemoteMethods {
    
    private let db = Firestore.firestore().collection(Environment.dbs).document(Environment.env)
    
    func user(_ id: String, completion: @escaping (UserModel?, _ listener: ListenerRegistration?) -> Void) {
        guard id.count > 0 else { completion(nil, nil); return }
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
    
    func creation(_ id: String, completion: @escaping (CreationModel?, _ listener: ListenerRegistration?) -> Void) {
        guard id.count > 0 else { completion(nil, nil); return }
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
    
    func comment(_ id: String, completion: @escaping (CommentModel?, _ listener: ListenerRegistration?) -> Void) {
        guard id.count > 0 else { completion(nil, nil); return }
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
    
    func like(_ id: String, completion: @escaping (LikeModel?, _ listener: ListenerRegistration?) -> Void) {
        guard id.count > 0 else { completion(nil, nil); return }
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
    
    func users(completion: @escaping ([UserModel]?, _ listener: ListenerRegistration?) -> Void) {
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
    
    func creations(completion: @escaping ([CreationModel]?, _ listener: ListenerRegistration?) -> Void) {
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
    
    func comments(completion: @escaping ([CommentModel]?, _ listener: ListenerRegistration?) -> Void) {
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
    
    func likes(completion: @escaping ([LikeModel]?, _ listener: ListenerRegistration?) -> Void) {
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
    
    func messages(conversationID: String, completion: @escaping ([MessageModel]?, _ listener: ListenerRegistration?) -> Void) {
        guard conversationID.count > 0 else { completion(nil, nil); return }
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.conversations.rawValue)
            .document(conversationID)
            .collection(Collections.messages.rawValue)
            .addSnapshotListener(includeMetadataChanges: false, listener: { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(nil, nil)
                    return
                }
                var models = [MessageModel]()
                snapshot.documents.forEach({ doc in
                    do {
                        let model = try FirestoreDecoder().decode(MessageModel.self, from: doc.data())
                        models.append(model)
                    } catch {
                        print("doc error")
                    }
                })
                completion(models, lstn)
            })
    }
    
    func usersWithPredicate(field: String, value: String, completion: @escaping ([UserModel]?, _ listener: ListenerRegistration?) -> Void) {
        guard field.count > 0, value.count > 0 else { completion(nil, nil); return }
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
    
    func creationsWithPredicate(field: String, value: String, completion: @escaping ([CreationModel]?, _ listener: ListenerRegistration?) -> Void) {
        guard field.count > 0, value.count > 0 else { completion(nil, nil); return }
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
    
    func commentsWithPredicate(field: String, value: String, completion: @escaping ([CommentModel]?, _ listener: ListenerRegistration?) -> Void) {
        guard field.count > 0, value.count > 0 else { completion(nil, nil); return }
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
    
    func likesWithPredicate(field: String, value: String, completion: @escaping ([LikeModel]?, _ listener: ListenerRegistration?) -> Void) {
        guard field.count > 0, value.count > 0 else { completion(nil, nil); return }
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
    
    func userLikes(_ userID: String, completion: @escaping ([UserLikeModel]?, _ listener: ListenerRegistration?) -> Void) {
        guard userID.count > 0 else { completion(nil, nil); return }
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.users.rawValue)
            .document(userID)
            .collection(Collections.likes.rawValue)
            .addSnapshotListener(includeMetadataChanges: false, listener: { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(nil, nil)
                    return
                }
                var models = [UserLikeModel]()
                snapshot.documents.forEach({ doc in
                    do {
                        let model = try FirestoreDecoder().decode(UserLikeModel.self, from: doc.data())
                        models.append(model)
                    } catch {
                        print("doc error")
                    }
                })
                completion(models, lstn)
        })
    }
    
    func userLikedWithPredicate(userID: String, field: String, value: String, completion: @escaping ([LikeModel]?, _ listener: ListenerRegistration?) -> Void) {
        guard userID.count > 0, field.count > 0, value.count > 0 else { completion(nil, nil); return }
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.users.rawValue)
            .document(userID)
            .collection(Collections.likes.rawValue)
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
    
    func conversationsWithPredicate(field: String, value: String, completion: @escaping ([ConversationModel]?, _ listener: ListenerRegistration?) -> Void) {
        var lstn: ListenerRegistration?
        lstn = db.collection(Collections.conversations.rawValue)
            .whereField(field, arrayContains: value)
            .addSnapshotListener(includeMetadataChanges: false, listener: { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(nil, nil)
                    return
                }
                var models = [ConversationModel]()
                snapshot.documents.forEach({ doc in
                    do {
                        let model = try FirestoreDecoder().decode(ConversationModel.self, from: doc.data())
                        models.append(model)
                    } catch {
                        print("doc error")
                    }
                })
                completion(models, lstn)
            })
    }
    
}
