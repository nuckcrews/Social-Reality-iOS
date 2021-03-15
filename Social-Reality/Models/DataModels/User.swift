//
//  User.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import UIKit
import Amplify
import AmplifyPlugins

class User : ObservableObject {
    
    private var _id: String!
    private var _model: UserModel?
    var creations = [CreationModel]()
    
    var str = ""
    
    var id: String! {
        return _id
    }
    var model: UserModel? {
        return _model
    }
    
    init(id: String) {
        _id = id
    }
    
    init(item: UserModel) {
        _id = item.id
        _model = item
    }
    
    public func getModel(id: String, completion: @escaping(_ result: ResultType) -> Void) {
        Query.datastore.get.user(id: id) { (res) in
            guard let res = res else {
                completion(.error)
                return
            }
            print(res)
            self._model = res
            completion(.success)
        }
    }
    
    public func subscribeToUser(id: String) {
        Query.datastore.subscribe.user(id: id) { (res, event) in
            guard let res = res else { return }
            print(res)
            print(event as Any)
            
            self._model = res
        }
    }
    
    public func cancelSubscription() {
//        subscription?.cancel()
    }
    
    public func getCreations(id: String) {
        Query.datastore.get.userCreations(id: id) { (res) in
            guard let res = res else { return }
            print(res)
            self.creations = res
        }
    }
    
    public func updateUser(item: UserModel) {
        _model = item
        Query.datastore.update.user(item) { (res) in
            print(res)
        }
    }
    
    public func delete() {
        guard let user = model else { return }
        Query.datastore.delete.user(user) { (res) in
            print(res)
        }
    }
    
}
