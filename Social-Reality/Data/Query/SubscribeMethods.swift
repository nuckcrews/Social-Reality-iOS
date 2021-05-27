//
//  SubscribeMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation
import Firebase

struct SubscribeMethods {
    
    func user(id: String, completion: @escaping(_ result: UserModel?, _ listener: ListenerRegistration?) -> Void) {
        
        guard id.count > 0 else { completion(nil, nil); return }
        
        if let model = Cache.get.user(id) {
            completion(model, nil)
        }
        
        Remote.subscribe.user(id: id) { model, lstn in
            guard let model = model else { return }
            Cache.write.user(model)
            completion(model, lstn)
        }
        
    }
    
}
