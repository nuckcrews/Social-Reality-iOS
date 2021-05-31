//
//  Comment.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation

class Comment {
    
    private var _id: String!
    private var _model: CommentModel?
    
    public var user: UserModel?
    public var creation: CreationModel?
    
    var id: String! {
        return _id
    }
    var model: CommentModel? {
        return _model
    }
    
    
    init(id: String) {
        _id = id
    }
    
    init(model: CommentModel) {
        _id = model.id
        _model = model
    }
    
    private func getModel(completion: @escaping(_ result: CommentModel?) -> Void) {
        Query.remote.get.comment(id) { [weak self] result in
            if result != nil {
                self?._model = result
            }
            completion(result)
        }
    }
    
    public func updateModel(data: [String: Any], completion: @escaping(_ result: ResultType?) -> Void) {
        Query.remote.update.comment(id, data: data) { res in
            completion(res)
        }
    }
    
    public func deleteModel() {
        Query.delete.comment(id) { _ in }
    }
    
    
}
