//
//  ReadRemoteMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Firebase
import CodableFirebase

// MARK: Read Remote Query Methods - Local

struct ReadRemoteMethods {
    
    private let db = Firestore.firestore().collection(Environment.dbs).document(Environment.env)
    
    func user(id: String, completion: @escaping(_ result: UserModel?) -> Void) {
        guard id.count > 0 else { completion(nil); return }
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
        guard id.count > 0 else { completion(nil); return }
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
        guard id.count > 0 else { completion(nil); return }
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
        guard id.count > 0 else { completion(nil); return }
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
    
    func message(conversationID: String, id: String, completion: @escaping(_ result: MessageModel?) -> Void) {
        guard conversationID.count > 0, id.count > 0 else { completion(nil); return }
        db.collection(Collections.conversations.rawValue)
            .document(conversationID)
            .collection(Collections.messages.rawValue)
            .document(id).getDocument { snapshot, error in
                if error != nil || snapshot == nil {
                    completion(nil)
                } else {
                    if let data = snapshot?.data() {
                        do {
                            let model = try FirestoreDecoder().decode(MessageModel.self, from: data)
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
    
    func conversation(id: String, completion: @escaping(_ result: ConversationModel?) -> Void) {
        guard id.count > 0 else { completion(nil); return }
        db.collection(Collections.conversations.rawValue).document(id).getDocument { snapshot, error in
            if error != nil || snapshot == nil {
                completion(nil)
            } else {
                if let data = snapshot?.data() {
                    do {
                        let model = try FirestoreDecoder().decode(ConversationModel.self, from: data)
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
                    print("Does not exist")
                    completion(nil)
                }
            }
        }
    }
    
    func usersWithPredicate(field: String, value: String, completion: @escaping(_ result: [UserModel]?) -> Void) {
        guard field.count > 0, value.count > 0 else { completion(nil); return }
        db.collection(Collections.users.rawValue)
            .whereField(field, isEqualTo: value).getDocuments { snapshot, error in
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
                        print("Does not exist")
                        completion(nil)
                    }
                }
            }
    }
    
    func creations(completion: @escaping(_ result: [CreationModel]?) -> Void) {
        db.collection(Collections.creations.rawValue).getDocuments { snapshot, error in
            if error != nil || snapshot == nil {
                completion(nil)
            } else {
                if let docs = snapshot?.documents {
                    do {
                        var models = [CreationModel]()
                        try docs.forEach { doc in
                            let model = try FirestoreDecoder().decode(CreationModel.self, from: doc.data())
                            models.append(model)
                        }
                        completion(models)
                    } catch {
                        completion(nil)
                    }
                } else {
                    print("Does not exist")
                    completion(nil)
                }
            }
        }
    }
    
    func creationsWithPredicate(field: String, value: String, completion: @escaping(_ result: [CreationModel]?) -> Void) {
        guard field.count > 0, value.count > 0 else { completion(nil); return }
        db.collection(Collections.creations.rawValue)
            .whereField(field, isEqualTo: value).getDocuments { snapshot, error in
                if error != nil || snapshot == nil {
                    completion(nil)
                } else {
                    if let docs = snapshot?.documents {
                        do {
                            var models = [CreationModel]()
                            try docs.forEach { doc in
                                let model = try FirestoreDecoder().decode(CreationModel.self, from: doc.data())
                                models.append(model)
                            }
                            completion(models)
                        } catch {
                            completion(nil)
                        }
                    } else {
                        print("Does not exist")
                        completion(nil)
                    }
                }
            }
    }
    
    func comments(completion: @escaping(_ result: [CommentModel]?) -> Void) {
        db.collection(Collections.comments.rawValue).getDocuments { snapshot, error in
            if error != nil || snapshot == nil {
                completion(nil)
            } else {
                if let docs = snapshot?.documents {
                    do {
                        var models = [CommentModel]()
                        try docs.forEach { doc in
                            let model = try FirestoreDecoder().decode(CommentModel.self, from: doc.data())
                            models.append(model)
                        }
                        completion(models)
                    } catch {
                        completion(nil)
                    }
                } else {
                    print("Does not exist")
                    completion(nil)
                }
            }
        }
    }
    
    func commentsWithPredicate(field: String, value: String, completion: @escaping(_ result: [CommentModel]?) -> Void) {
        guard field.count > 0, value.count > 0 else { completion(nil); return }
        db.collection(Collections.comments.rawValue)
            .whereField(field, isEqualTo: value).getDocuments { snapshot, error in
                if error != nil || snapshot == nil {
                    completion(nil)
                } else {
                    if let docs = snapshot?.documents {
                        do {
                            var models = [CommentModel]()
                            try docs.forEach { doc in
                                let model = try FirestoreDecoder().decode(CommentModel.self, from: doc.data())
                                models.append(model)
                            }
                            completion(models)
                        } catch {
                            completion(nil)
                        }
                    } else {
                        print("Does not exist")
                        completion(nil)
                    }
                }
            }
    }
    
    func likes(completion: @escaping(_ result: [LikeModel]?) -> Void) {
        db.collection(Collections.likes.rawValue).getDocuments { snapshot, error in
            if error != nil || snapshot == nil {
                completion(nil)
            } else {
                if let docs = snapshot?.documents {
                    do {
                        var models = [LikeModel]()
                        try docs.forEach { doc in
                            let model = try FirestoreDecoder().decode(LikeModel.self, from: doc.data())
                            models.append(model)
                        }
                        completion(models)
                    } catch {
                        completion(nil)
                    }
                } else {
                    print("Does not exist")
                    completion(nil)
                }
            }
        }
    }
    
    func likesWithPredicate(field: String, value: String, completion: @escaping(_ result: [LikeModel]?) -> Void) {
        guard field.count > 0, value.count > 0 else { completion(nil); return }
        db.collection(Collections.likes.rawValue)
            .whereField(field, isEqualTo: value).getDocuments { snapshot, error in
                if error != nil || snapshot == nil {
                    completion(nil)
                } else {
                    if let docs = snapshot?.documents {
                        do {
                            var models = [LikeModel]()
                            try docs.forEach { doc in
                                let model = try FirestoreDecoder().decode(LikeModel.self, from: doc.data())
                                models.append(model)
                            }
                            completion(models)
                        } catch {
                            completion(nil)
                        }
                    } else {
                        print("Does not exist")
                        completion(nil)
                    }
                }
            }
    }
    
    func messages(conversationID: String, completion: @escaping(_ result: [MessageModel]?) -> Void) {
        guard conversationID.count > 0 else { completion(nil); return }
        db.collection(Collections.conversations.rawValue)
            .document(conversationID)
            .collection(Collections.likes.rawValue).getDocuments { snapshot, error in
                if error != nil || snapshot == nil {
                    completion(nil)
                } else {
                    if let docs = snapshot?.documents {
                        do {
                            var models = [MessageModel]()
                            try docs.forEach { doc in
                                let model = try FirestoreDecoder().decode(MessageModel.self, from: doc.data())
                                models.append(model)
                            }
                            completion(models)
                        } catch {
                            completion(nil)
                        }
                    } else {
                        print("Does not exist")
                        completion(nil)
                    }
                }
            }
    }
    
}
