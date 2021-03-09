//
//  DeleteMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Amplify
import AmplifyPlugins

// MARK: Delete Query Methods - Local

struct DataStoreDeleteMethods {
    
    func user(_ item: UserModel, completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.DataStore.delete(item) {
            switch $0 {
            case .success:
                print("Deleted!")
                completion(.success)
            case .failure(let error):
                print("Error deleting - \(error.localizedDescription)")
                completion(.error)
            }
        }
    }
    
    func creation(_ item: CreationModel, completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.DataStore.delete(item) {
            switch $0 {
            case .success:
                print("Deleted!")
                completion(.success)
            case .failure(let error):
                print("Error deleting - \(error.localizedDescription)")
                completion(.error)
            }
        }
    }
    
    func comment(_ item: CommentModel, completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.DataStore.delete(item) {
            switch $0 {
            case .success:
                print("Deleted!")
                completion(.success)
            case .failure(let error):
                print("Error deleting - \(error.localizedDescription)")
                completion(.error)
            }
        }
    }
    
    func like(_ item: LikeModel, completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.DataStore.delete(item) {
            switch $0 {
            case .success:
                print("Deleted!")
                completion(.success)
            case .failure(let error):
                print("Error deleting - \(error.localizedDescription)")
                completion(.error)
            }
        }
    }
    
}
