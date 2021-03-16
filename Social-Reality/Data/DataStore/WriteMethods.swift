//
//  WriteMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Amplify
import AmplifyPlugins

// MARK: Write Query Methods - Local

struct DataStoreWriteMethods {
    
    func user(_ user: UserModel, completion: @escaping(_ result: UserModel?) -> Void) {
        Amplify.DataStore.save(user) { result in
            switch result {
            case .success(let item):
                print("User saved - \(item)")
                completion(item)
            case .failure(let error):
                print("Could not create - \(error)")
                completion(nil)
            }
        }
    }
    
    func creation(_ creation: CreationModel, completion: @escaping(_ result: CreationModel?) -> Void) {
        Amplify.DataStore.save(creation) { result in
            switch result {
            case .success(let item):
                print("Creation saved - \(item)")
                completion(item)
            case .failure(let error):
                print("Could not create - \(error)")
                completion(nil)
            }
        }
    }
    
    func comment(_ comment: CommentModel, completion: @escaping (_ result: CommentModel?) -> Void) {
        Amplify.DataStore.save(comment) { result in
            switch result {
            case .success(let item):
                print("Comment saved - \(item)")
                completion(item)
            case .failure(let error):
                print("Could not create - \(error)")
                completion(nil)
            }
        }
    }

    func like( _ like: LikeModel, completion: @escaping (_ result: LikeModel?) -> Void) {
        Amplify.DataStore.save(like) { result in
            switch result {
            case .success(let item):
                print("Like saved - \(item)")
                completion(item)
            case .failure(let error):
                print("Could not create - \(error)")
                completion(nil)
            }
        }
    }

    func email( _ email: EmailModel, completion: @escaping (_ result: EmailModel?) -> Void) {
        Amplify.DataStore.save(email) { result in
            switch result {
            case .success(let item):
                print("Email saved - \(item)")
                completion(item)
            case .failure(let error):
                print("Could not create - \(error)")
                completion(nil)
            }
        }
    }

    
}
