//
//  User.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Firebase

class User {
    
    private var _id: String!
    private var _model: UserModel?
    
    private var userListener: ListenerRegistration?
    private var creationListener: ListenerRegistration?
    private var commentListener: ListenerRegistration?
    private var likeListener: ListenerRegistration?
    
    public var creations: [CreationModel]?
    public var comments: [CommentModel]?
    public var likes: [LikeModel]?
    
    var id: String! { return _id }
    var model: UserModel? { return _model }
    
    init(id: String) { _id = id }
    init(model: UserModel) { _id = model.id; _model = model }
    
}

extension User {
    
    public func getModel(completion: @escaping(_ result: UserModel?) -> Void) {
        Query.get.user(id: id) { res in
            guard let res = res else { completion(nil); return }
            self._model = res
            completion(res)
        }
    }
    
    public func subscribeModel(completion: @escaping(_ result: UserModel?) -> Void) {
        Query.subscribe.user(id: id) { res, lstn in
            if res != nil {
                self._model = res
                self.userListener = lstn
                completion(res)
            } else {
                completion(nil)
            }
        }
    }
    
    public func cancelSubscription() {
        userListener?.remove()
        userListener = nil
    }
    
    public func updateModel(data: [String: Any], completion: @escaping(_ result: ResultType) -> Void) {
        Query.update.user(id: id, data: data) { res in
            completion(res)
        }
    }
    
    public func deleteModel() {
        Query.delete.user(id) { _ in }
    }
    
    public func getCreations(completion: @escaping(_ result: [CreationModel]?) -> Void) {
        Query.get.creationsWithPredicate(field: "userID", value: id) { result in
            if result != nil {
                self.creations = result
            }
            completion(result)
        }
    }
    
    public func getComments(completion: @escaping(_ result: [CommentModel]?) -> Void) {
        Query.get.commentsWithPredicate(field: "userID", value: id) { result in
            if result != nil {
                self.comments = result
            }
            completion(result)
        }
    }
    
    public func getLikes(completion: @escaping(_ result: [LikeModel]?) -> Void) {
        Query.get.likesWithPredicate(field: "userID", value: id) { result in
            if result != nil {
                self.likes = result
            }
            completion(result)
        }
    }
    
    public func subscribeCreations(completion: @escaping(_ result: [CreationModel]?) -> Void) {
        Query.subscribe.creationsWithPredicate(field: "userID", value: id) { result, lstn  in
            if result != nil {
                self.creations = result
                self.creationListener = lstn
            }
            completion(result)
        }
    }
    
    public func cancelCreationsSubscription() {
        creationListener?.remove()
        creationListener = nil
    }
    
    public func subscribeComments(completion: @escaping(_ result: [CommentModel]?) -> Void) {
        Query.subscribe.commentsWithPredicate(field: "userID", value: id) { result, lstn  in
            if result != nil {
                self.comments = result
                self.commentListener = lstn
            }
            completion(result)
        }
    }
    
    public func cancelCommentsSubscription() {
        commentListener?.remove()
        commentListener = nil
    }
    
    public func subscribeLikes(completion: @escaping(_ result: [LikeModel]?) -> Void) {
        Query.subscribe.likesWithPredicate(field: "userID", value: id) { result, lstn  in
            if result != nil {
                self.likes = result
                self.likeListener = lstn
            }
            completion(result)
        }
    }
    
    public func cancelLikesSubscription() {
        likeListener?.remove()
        likeListener = nil
    }
    
}
