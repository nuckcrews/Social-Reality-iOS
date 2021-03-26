//
//  Creation.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Firebase

class Creation {
    
    private var _id: String!
    private var _model: CreationModel?
    
    private var userListener: ListenerRegistration?
    private var creationListener: ListenerRegistration?
    private var commentListener: ListenerRegistration?
    private var likeListener: ListenerRegistration?
    
    public var user: UserModel?
    public var comments: [CommentModel]?
    public var likes: [LikeModel]?
    
    var id: String! { return _id }
    var model: CreationModel? { return _model }
    
    init(id: String) { _id = id }
    init(model: CreationModel) { _id = model.id; _model = model }
    
}

extension Creation {
    
    public func getModel(completion: @escaping(_ result: CreationModel?) -> Void) {
        Query.get.creation(id: id) { res in
            guard let res = res else { completion(nil); return }
            self._model = res
            completion(res)
        }
    }
    
    public func subscribeModel(completion: @escaping(_ result: CreationModel?) -> Void) {
        Query.subscribe.creation(id: id) { res, lstn in
            if res != nil {
                self._model = res
                self.creationListener = lstn
                completion(res)
            } else {
                completion(nil)
            }
        }
    }
    
    public func cancelSubscription() {
        creationListener?.remove()
        creationListener = nil
    }
    
    public func updateModel(data: [String: Any], completion: @escaping(_ result: ResultType) -> Void) {
        Query.update.creation(id: id, data: data) { res in
            completion(res)
        }
    }
    
    public func deleteModel() {
        Query.delete.creation(id) { _ in }
    }
    
    public func getUser(completion: @escaping(_ result: UserModel?) -> Void) {
        guard let userID = _model?.userID else { completion(nil); return }
        Query.get.user(id: userID) { result in
            if result != nil {
                self.user = result
            }
            completion(result)
        }
    }
    
    public func getComments(completion: @escaping(_ result: [CommentModel]?) -> Void) {
        Query.get.commentsWithPredicate(field: "creationID", value: id) { result in
            if result != nil {
                self.comments = result
            }
            completion(result)
        }
    }
    
    public func getLikes(completion: @escaping(_ result: [LikeModel]?) -> Void) {
        Query.get.likesWithPredicate(field: "creationID", value: id) { result in
            if result != nil {
                self.likes = result
            }
            completion(result)
        }
    }
    
    public func subscribeUser(completion: @escaping(_ result: UserModel?) -> Void) {
        guard let userID = _model?.userID else { completion(nil); return }
        Query.subscribe.user(id: userID) { result, lstn in
            if result != nil {
                self.user = result
                self.userListener = lstn
            }
            completion(result)
        }
    }
    
    public func cancelUserSubscription() {
        userListener?.remove()
        userListener = nil
    }
    
    public func subscribeComments(completion: @escaping(_ result: [CommentModel]?) -> Void) {
        Query.subscribe.commentsWithPredicate(field: "creationID", value: id) { result, lstn  in
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
        Query.subscribe.likesWithPredicate(field: "creationID", value: id) { result, lstn  in
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