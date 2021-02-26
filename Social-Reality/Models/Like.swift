//
//  Like.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import UIKit
import Amplify
import AmplifyPlugins

class Like : ObservableObject {
    
    var model: LikeModel?
    
    init(item: LikeModel, subscribe: Bool) {
        model = item
        subscribe ? subscribeToLike(id: item.id) : getLike(id: item.id)
    }
    
    init(id: String, subscribe: Bool) {
        subscribe ? subscribeToLike(id: id) : getLike(id: id)
    }
    
    private func getLike(id: String) {
        Query.get.like(id: id) { (res) in
            guard let res = res else { return }
            print(res)
            self.model = res
        }
    }
    
    private func subscribeToLike(id: String) {
        Query.subscribe.like(id: id) { (res, event) in
            guard let res = res else { return }
            print(res)
            print(event as Any)
            
            self.model = res
        }
    }
    
    public func cancelSubscription() {
//        subscription?.cancel()
    }
    
    public func updateLike(item: LikeModel) {
        model = item
        Query.update.like(item) { (res) in
            print(res)
        }
    }
    
    public func delete() {
        guard let model = model else { return }
        Query.delete.like(model) { (res) in
            print(res)
        }
    }
    
}
