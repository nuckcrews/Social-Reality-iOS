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
    
    var model: UserModel?
    var creations = [CreationModel]()
    
    init(item: UserModel, subscribe: Bool) {
        model = item
        subscribe ? subscribeToUser(id: item.id) : getUser(id: item.id)
    }
    
    init(id: String, subscribe: Bool) {
        subscribe ? subscribeToUser(id: id) : getUser(id: id)
    }
    
    private func getUser(id: String) {
        Query.get.user(id: id) { (res) in
            guard let res = res else { return }
            print(res)
            self.model = res
        }
    }
    
    private func subscribeToUser(id: String) {
        Query.subscribe.user(id: id) { (res, event) in
            guard let res = res else { return }
            print(res)
            print(event as Any)
            
            self.model = res
        }
    }
    
    public func cancelSubscription() {
//        subscription?.cancel()
    }
    
    public func getCreations(id: String) {
        Query.get.userCreations(id: id) { (res) in
            guard let res = res else { return }
            print(res)
            self.creations = res
        }
    }
    
    public func updateUser(item: UserModel) {
        model = item
        Query.update.user(item) { (res) in
            print(res)
        }
    }
    
    public func delete() {
        guard let user = model else { return }
        Query.delete.user(user) { (res) in
            print(res)
        }
    }
    
}
