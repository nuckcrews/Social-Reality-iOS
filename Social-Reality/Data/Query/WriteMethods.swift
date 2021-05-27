//
//  WriteMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/27/21.
//

import Foundation

struct WriteMethods {
    
    func user(model: UserModel, completion: @escaping(_ result: ResultType) -> Void) {
        
        Cache.write.user(model)
        
        Remote.write.user(model) { result in
            completion(result)
        }
        
    }
    
}
