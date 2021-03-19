//
//  Like.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import UIKit

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
    
    private func getModel(id: String) {

    }
    
    private func subscribeModel(id: String) {

    }
    
    public func cancelSubscription() {
        
    }
    
    public func updateModel(item: LikeModel) {

    }
    
    public func deleteModel() {

    }
    
    
    
}
