//
//  Creation.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import UIKit
import Amplify
import AmplifyPlugins

class Creation : ObservableObject {
    
    
    private var _id: String!
    private var _model: CreationModel?

    var id: String! {
        return _id
    }
    var model: CreationModel? {
        return _model
    }
    
    var user: User?
    
    init(id: String) {
        _id = id
    }
    
    init(item: CreationModel) {
        _id = item.id
        _model = item
    }
    
    public func getCreation(id: String, completion: @escaping(_ result: ResultType) -> Void) {
        Query.datastore.get.creation(id: id) { (res) in
            guard let res = res else { completion(.error); return }
            print(res)
            self._model = res
            completion(.success)
        }
    }
    
    public func getCreationWithUser(id: String, completion: @escaping(_ result: ResultType) -> Void) {
        Query.datastore.get.creation(id: id) { (res) in
            guard let res = res else { completion(.error); return }
            print(res)
            self._model = res
            if let userID = res.userID {
                self.user = User(id: userID)
                self.user?.getModel(id: userID, completion: { result in
                    print(result)
                    completion(.success)
                })
            } else {
                completion(.error)
            }
        }
    }
    
    private func subscribeToCreation(id: String) {
        Query.datastore.subscribe.creation(id: id) { (res, event) in
            guard let res = res else { return }
            print(res)
            print(event as Any)
            
            self._model = res
        }
    }
    
    public func cancelSubscription() {
//        subscription?.cancel()
    }
    
    public func updateCreation(item: CreationModel) {
        _model = item
        Query.datastore.update.creation(item) { (res) in
            print(res)
        }
    }
    
    public func delete() {
        guard let model = model else { return }
        Query.datastore.delete.creation(model) { (res) in
            print(res)
        }
    }
    
}
