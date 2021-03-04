//
//  Comment.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import UIKit
import Amplify
import AmplifyPlugins

class Comment : ObservableObject {
    
    var model: CommentModel?
    
    init(item: CommentModel, subscribe: Bool) {
        model = item
        subscribe ? subscribeToComment(id: item.id) : getComment(id: item.id)
    }
    
    init(id: String, subscribe: Bool) {
        subscribe ? subscribeToComment(id: id) : getComment(id: id)
    }
    
    private func getComment(id: String) {
        Query.get.comment(id: id) { (res) in
            guard let res = res else { return }
            print(res)
            self.model = res
        }
    }
    
    private func subscribeToComment(id: String) {
        Query.subscribe.comment(id: id) { (res, event) in
            guard let res = res else { return }
            print(res)
            print(event as Any)
            
            self.model = res
        }
    }
    
    public func cancelSubscription() {
//        subscription?.cancel()
    }
    
    public func updateComment(item: CommentModel) {
        model = item
        Query.update.comment(item) { (res) in
            print(res)
        }
    }
    
    public func delete() {
        guard let model = model else { return }
        Query.delete.comment(model) { (res) in
            print(res)
        }
    }
    
}
