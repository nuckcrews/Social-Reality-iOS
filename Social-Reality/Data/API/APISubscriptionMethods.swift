//
//  APISubscriptionMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/8/21.
//

import Foundation
import Amplify
import AmplifyPlugins

// MARK: Subscribe Query Methods - Cloud

struct APISubscribeMethods {
    
    func user(id: String, completion: @escaping(_ result: UserModel?, _ type: EventType?) -> Void) {

    }
    
    func creation(id: String, completion: @escaping(_ result: CreationModel?, _ type: EventType?) -> Void) {
       
    }
    
    func comment(id: String, completion: @escaping(_ result: CommentModel?, _ type: EventType?) -> Void) {
        
    }
    
    func like(id: String, completion: @escaping(_ result: LikeModel?, _ type: EventType?) -> Void) {
        
    }
    
}