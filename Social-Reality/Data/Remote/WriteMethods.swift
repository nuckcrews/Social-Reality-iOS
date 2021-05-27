//
//  WriteRemoteMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Firebase
import CodableFirebase

// MARK: - Write Remote Query Methods - Local

struct WriteRemoteMethods {
    
    private let db = Firestore.firestore().collection(Environment.dbs).document(Environment.env)
    
    func user(_ user: UserModel, completion: @escaping(_ result: ResultType) -> Void) {
        guard user.id.count > 0  else { completion(.error); return }
        do {
            let docData = try FirestoreEncoder().encode(user)
            db.collection(Collections.users.rawValue).document(user.id).setData(docData, merge: true, completion: { error in
                if let error = error {
                    print("Error writing document: \(error)")
                    completion(.error)
                } else {
                    print("Document successfully written!")
                    completion(.success)
                }
            })
        } catch {
            completion(.error)
        }
    }
    
    func creation(_ creation: CreationModel, completion: @escaping(_ result: ResultType) -> Void) {
        guard creation.id.count > 0  else { completion(.error); return }
        do {
            let docData = try FirestoreEncoder().encode(creation)
            db.collection(Collections.creations.rawValue).document(creation.id).setData(docData, merge: true, completion: { error in
                if let error = error {
                    print("Error writing document: \(error)")
                    completion(.error)
                } else {
                    print("Document successfully written!")
                    completion(.success)
                }
            })
        } catch {
            completion(.error)
        }
    }
    
    func comment(_ comment: CommentModel, completion: @escaping (_ result: ResultType) -> Void) {
        guard comment.id.count > 0  else { completion(.error); return }
        do {
            let docData = try FirestoreEncoder().encode(comment)
            db.collection(Collections.comments.rawValue).document(comment.id).setData(docData, merge: true, completion: { error in
                if let error = error {
                    print("Error writing document: \(error)")
                    completion(.error)
                } else {
                    print("Document successfully written!")
                    completion(.success)
                }
            })
        } catch {
            completion(.error)
        }
    }
    
    func like( _ like: LikeModel, completion: @escaping (_ result: ResultType) -> Void) {
        guard like.id.count > 0  else { completion(.error); return }
        do {
            let docData = try FirestoreEncoder().encode(like)
            db.collection(Collections.likes.rawValue).document(like.id).setData(docData, merge: true, completion: { error in
                if let error = error {
                    print("Error writing document: \(error)")
                    completion(.error)
                } else {
                    print("Document successfully written!")
                    completion(.success)
                }
            })
        } catch {
            completion(.error)
        }
    }
    
    func message(_ message: MessageModel, completion: @escaping(_ result: ResultType) -> Void) {
        guard message.id.count > 0 else { completion(.error); return }
        do {
            let docData = try FirestoreEncoder().encode(message)
            db.collection(Collections.conversations.rawValue)
                .document(message.conversationID)
                .collection(Collections.messages.rawValue)
                .document(message.id).setData(docData, merge: true, completion: { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                        completion(.error)
                    } else {
                        print("Document successfully written!")
                        completion(.success)
                    }
                })
        } catch {
            completion(.error)
        }
    }
    
    func conversation(_ conversation: ConversationModel, completion: @escaping(_ result: ResultType) -> Void) {
        guard conversation.id.count > 0 else { completion(.error); return }
        do {
            let docData = try FirestoreEncoder().encode(conversation)
            db.collection(Collections.conversations.rawValue)
                .document(conversation.id)
                .setData(docData, merge: true, completion: { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                        completion(.error)
                    } else {
                        print("Document successfully written!")
                        completion(.success)
                    }
                })
        } catch {
            completion(.error)
        }
    }
    
}
