//
//  APIUpdateMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/8/21.
//

import Foundation
import Amplify
import AmplifyPlugins

// MARK: Update Query Methods - Cloud

struct APIUpdateMethods {
    
    func user(_ user: UserModel, completion: @escaping(_ result: ResultType) -> Void) {
        print(user)
        Amplify.API.mutate(request: .update(user)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let item):
                    print("Successfully updated: \(item)")
                    completion(.success)
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                    completion(.error)
                }
            case .failure(let error):
                print("Got failed event with error \(error)")
                completion(.error)
            }
        }
    }
    
    func creation(_ creation: CreationModel, completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.API.mutate(request: .update(creation)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let item):
                    print("Successfully updated: \(item)")
                    completion(.success)
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                    completion(.error)
                }
            case .failure(let error):
                print("Got failed event with error \(error)")
                completion(.error)
            }
        }
    }
    
    func comment(_ comment: CommentModel, completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.API.mutate(request: .update(comment)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let item):
                    print("Successfully updated: \(item)")
                    completion(.success)
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                    completion(.error)
                }
            case .failure(let error):
                print("Got failed event with error \(error)")
                completion(.error)
            }
        }
    }
    
    func like(_ like: LikeModel, completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.API.mutate(request: .update(like)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let item):
                    print("Successfully updated: \(item)")
                    completion(.success)
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                    completion(.error)
                }
            case .failure(let error):
                print("Got failed event with error \(error)")
                completion(.error)
            }
        }
    }
    
}
