//
//  UpdateMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Amplify
import AmplifyPlugins

struct UpdateMethods {
    
    func user(_ item: UserModel, completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.DataStore.save(item) {
            switch $0 {
            case .success:
                print("Updated the existing user")
                completion(.success)
            case .failure(let error):
                print("Error updating user - \(error.localizedDescription)")
                completion(.error)
            }
        }
    }
    
    func creation(_ item: CreationModel, completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.DataStore.save(item) {
            switch $0 {
            case .success:
                print("Updated the existing creation")
                completion(.success)
            case .failure(let error):
                print("Error updating creation - \(error.localizedDescription)")
                completion(.error)
            }
        }
    }
    
    func comment(_ item: CommentModel, completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.DataStore.save(item) {
            switch $0 {
            case .success:
                print("Updated the existing comment")
                completion(.success)
            case .failure(let error):
                print("Error updating comment - \(error.localizedDescription)")
                completion(.error)
            }
        }
    }
    
    func like(_ item: LikeModel, completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.DataStore.save(item) {
            switch $0 {
            case .success:
                print("Updated the existing like")
                completion(.success)
            case .failure(let error):
                print("Error updating like - \(error.localizedDescription)")
                completion(.error)
            }
        }
    }
    
}
