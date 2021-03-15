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
    
    var model: CreationModel?
    
    init(item: CreationModel, subscribe: Bool) {
        model = item
        subscribe ? subscribeToCreation(id: item.id) : getCreation(id: item.id)
    }
    
    init(id: String, subscribe: Bool) {
        subscribe ? subscribeToCreation(id: id) : getCreation(id: id)
    }
    
    private func getCreation(id: String) {
        Query.datastore.get.creation(id: id) { (res) in
            guard let res = res else { return }
            print(res)
            self.model = res
        }
    }
    
    private func subscribeToCreation(id: String) {
        Query.datastore.subscribe.creation(id: id) { (res, event) in
            guard let res = res else { return }
            print(res)
            print(event as Any)
            
            self.model = res
        }
    }
    
    public func cancelSubscription() {
//        subscription?.cancel()
    }
    
    public func updateCreation(item: CreationModel) {
        model = item
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
