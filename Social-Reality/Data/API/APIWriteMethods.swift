//
//  APIWriteMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/8/21.
//

import Foundation
import Amplify
import AmplifyPlugins

// MARK: Write Query Methods - Cloud

struct APIWriteMethods {
    
    func user(_ user: UserModel, completion: @escaping(_ result: UserModel?) -> Void) {
        Amplify.API.mutate(request: .create(user)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let item):
                    print("Successfully created: \(item)")
                    completion(item)
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                    completion(nil)
                }
            case .failure(let error):
                print("Got failed event with error \(error)")
                completion(nil)
            }
        }
    }
    
    func creation(_ creation: CreationModel, completion: @escaping(_ result: CreationModel?) -> Void) {
        Amplify.API.mutate(request: .create(creation)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let item):
                    print("Successfully created: \(item)")
                    completion(item)
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                    completion(nil)
                }
            case .failure(let error):
                print("Got failed event with error \(error)")
                completion(nil)
            }
        }
    }
    
    func comment(_ comment: CommentModel, completion: @escaping (_ result: CommentModel?) -> Void) {
        Amplify.API.mutate(request: .create(comment)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let item):
                    print("Successfully created: \(item)")
                    completion(item)
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                    completion(nil)
                }
            case .failure(let error):
                print("Got failed event with error \(error)")
                completion(nil)
            }
        }
    }

    func like( _ like: LikeModel, completion: @escaping (_ result: LikeModel?) -> Void) {
        Amplify.API.mutate(request: .create(like)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let item):
                    print("Successfully created: \(item)")
                    completion(item)
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                    completion(nil)
                }
            case .failure(let error):
                print("Got failed event with error \(error)")
                completion(nil)
            }
        }
    }

    
}
