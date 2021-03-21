//
//  Creation.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import UIKit

class Creation {
    
    private var _id: String!
    private var _model: CreationModel?
    
    public var user: UserModel?
    public var comments: [CommentModel]?
    public var likes: [LikeModel]?
    
    var id: String! { return _id }
    var model: CreationModel? { return _model }
    
    init(id: String) {
        _id = id
    }
    
    init(model: CreationModel) {
        _id = model.id
        _model = model
    }
    
    private func getModel(id: String) {

    }
    
    private func subscribeModel(id: String) {

    }
    
    public func cancelSubscription() {
        
    }
    
    public func updateModel(item: CreationModel) {

    }
    
    public func deleteModel() {

    }
    
    
    
}
