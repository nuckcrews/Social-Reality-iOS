//
//  ReadMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import Amplify
import AmplifyPlugins

// MARK: Read Query Methods - Local

struct DataStoreReadMethods {
    
    func user(id: String, completion: @escaping(_ result: UserModel?) -> Void) {
        Amplify.DataStore.query(UserModel.self, byId: id) { (result) in
            switch result {
            case .success(let queriedUser):
                if let queriedUser = queriedUser {
                    print("Found account - \(queriedUser)")
                    completion(queriedUser)
                } else {
                    print("No account found")
                    completion(nil)
                }
            case .failure(let error):
                print("Could not perform query for account - \(error)")
                completion(nil)
            }
        }
        
        
    }
    
    
    func usersWithPredicate(predicate: QueryPredicate?, completion: @escaping(_ result: [UserModel]?) -> Void) {
        Amplify.DataStore.query(UserModel.self, where: predicate, sort: nil, paginate: .firstPage) { (result) in
            switch result {
            case .success(let users):
                print("Got Users", users)
                completion(users)
            case .failure(let error):
                print(error)
                completion(nil)
            }
            
        }
    }
    

    
    func creation(id: String, completion: @escaping(_ result: CreationModel?) -> Void) {
        Amplify.DataStore.query(CreationModel.self, byId: id) { (result) in
            switch result {
            case .success(let queriedCreation):
                if let queriedCreation = queriedCreation {
                    print("Found creation - \(queriedCreation)")
                    completion(queriedCreation)
                } else {
                    print("No creation found")
                    completion(nil)
                }
            case .failure(let error):
                print("Could not perform query for account - \(error)")
                completion(nil)
            }
        }
    }
    
    func comment(id: String, completion: @escaping(_ result: CommentModel?) -> Void) {
        Amplify.DataStore.query(CommentModel.self, byId: id) { (result) in
            switch result {
            case .success(let queriedComment):
                if let queriedComment = queriedComment {
                    print("Found creation - \(queriedComment)")
                    completion(queriedComment)
                } else {
                    print("No creation found")
                    completion(nil)
                }
            case .failure(let error):
                print("Could not perform query for account - \(error)")
                completion(nil)
            }
        }
    }
    
    func like(id: String, completion: @escaping(_ result: LikeModel?) -> Void) {
        Amplify.DataStore.query(LikeModel.self, byId: id) { (result) in
            switch result {
            case .success(let queriedLike):
                if let queriedLike = queriedLike {
                    print("Found creation - \(queriedLike)")
                    completion(queriedLike)
                } else {
                    print("No creation found")
                    completion(nil)
                }
            case .failure(let error):
                print("Could not perform query for account - \(error)")
                completion(nil)
            }
        }
    }
    
    func emailsWithPredicate(predicate: QueryPredicate?, completion: @escaping(_ result: [EmailModel]?) -> Void) {
        Amplify.DataStore.query(EmailModel.self, where: predicate, sort: nil, paginate: .firstPage) { (result) in
            switch result {
            case .success(let emails):
                print("Got Emails", emails)
                completion(emails)
            case .failure(let error):
                print(error)
                completion(nil)
            }
            
        }
    }
    
    func userCreations(id: String, completion: @escaping(_ result: [CreationModel]?) -> Void) {

    }
    
    func userLikes(id: String, completion: @escaping(_ result: [LikeModel]?) -> Void) {

    }
    
    func userComments(id: String, completion: @escaping(_ result: [CommentModel]?) -> Void) {

    }
    
    func creationComments(id: String, completion: @escaping(_ result: [CommentModel]?) -> Void) {

    }
    
    func creationLikes(id: String, completion: @escaping(_ result: [LikeModel]?) -> Void) {

    }
    
}
