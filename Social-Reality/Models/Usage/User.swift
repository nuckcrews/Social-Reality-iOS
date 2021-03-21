//
//  User.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import UIKit

class User {
    
    private var _id: String!
    private var _model: UserModel?
    
    public var creations: [CreationModel]?
    public var comments: [CommentModel]?
    public var likes: [LikeModel]?
    
    var id: String! {
        return _id
    }
    var model: UserModel? {
        return _model
    }
    
    init(id: String) {
        _id = id
    }
    
    init(model: UserModel) {
        _id = model.id
        _model = model
    }
    
    public func getModel(id: String, completion: @escaping(_ result: UserModel?) -> Void) {
        Query.get.user(id: id) { res in
            guard let res = res else { completion(nil); return }
            self._model = res
            completion(res)
        }
    }
    
    public func subscribeModel(id: String) {

    }
    
    public func cancelSubscription() {
        
    }
    
    public func updateModel(data: [String: Any], completion: @escaping(_ result: ResultType) -> Void) {
        Query.update.user(id: id, data: data) { res in
            completion(res)
        }
    }
    
    public func deleteModel() {

    }
    
    
}
