//
//  ReadMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation

struct ReadMethods {
    
    func user(id: String, completion: @escaping(_ result: UserModel?) -> Void) {
        
        guard id.count > 0 else { completion(nil); return }
        
        if let model = Cache.get.user(id) {
            completion(model)
            return
        }
        
        Remote.get.user(id: id) { model in
            guard let model = model else { completion(nil); return }
            Cache.write.user(model)
            completion(model)
        }
        
    }
    
}
