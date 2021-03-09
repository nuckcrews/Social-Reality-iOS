//
//  APIDeleteMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/8/21.
//

import Foundation
import Amplify
import AmplifyPlugins

// MARK: Delete Query Methods - Cloud

struct APIDeleteMethods {
    
    func user(_ user: UserModel, completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.API.mutate(request: .delete(user)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let item):
                    print("Successfully deleted: \(item)")
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
        Amplify.API.mutate(request: .delete(creation)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let item):
                    print("Successfully deleted: \(item)")
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
        Amplify.API.mutate(request: .delete(comment)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let item):
                    print("Successfully deleted: \(item)")
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
        Amplify.API.mutate(request: .delete(like)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let item):
                    print("Successfully deleted: \(item)")
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
