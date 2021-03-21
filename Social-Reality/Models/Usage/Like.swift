//
//  Like.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation

class Like {
    
    private var _id: String!
    private var _model: LikeModel?
    
    public var user: UserModel?
    public var creation: CreationModel?
    
    var id: String! {
        return _id
    }
    var model: LikeModel? {
        return _model
    }
    
    init(id: String) {
        _id = id
    }
    
    init(model: LikeModel) {
        _id = model.id
        _model = model
    }
    
    private func getModel(completion: @escaping(_ result: LikeModel?) -> Void) {
        Query.get.like(id: id) { result in
            if result != nil {
                self._model = result
            }
            completion(result)
        }
    }
    
    public func updateModel(data: [String: Any], completion: @escaping(_ result: ResultType?) -> Void) {
        Query.update.like(id: id, data: data) { res in
            completion(res)
        }
    }
    
    public func deleteModel() {
        Query.delete.like(id) { _ in }
    }
    
    
    
}
