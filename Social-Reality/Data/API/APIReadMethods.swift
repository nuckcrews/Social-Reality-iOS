//
//  APIReadMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/8/21.
//

import Foundation
import Amplify
import AmplifyPlugins

// MARK: Read Query Methods - Cloud

struct APIReadMethods {
    
    func user(id: String, completion: @escaping(_ result: UserModel?) -> Void) {
        Amplify.API.query(request: .get(UserModel.self, byId: id)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let user):
                    guard let user = user else {
                        print("Could not find user")
                        completion(nil)
                        return
                    }
                    print("Successfully retrieved user: \(user)")
                    completion(user)
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
    
    
    func usersWithPredicate(predicate: QueryPredicate?, completion: @escaping(_ result: [UserModel]?) -> Void) {
        Amplify.API.query(request: .paginatedList(UserModel.self, where: predicate, limit: 1000)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let users):
                    print("Successfully retrieved list of users: \(users)")
                    completion(users.elements)
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
    

    
    func creation(id: String, completion: @escaping(_ result: CreationModel?) -> Void) {
        Amplify.API.query(request: .get(CreationModel.self, byId: id)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let creation):
                    guard let creation = creation else {
                        print("Could not find creation")
                        completion(nil)
                        return
                    }
                    print("Successfully retrieved creation: \(creation)")
                    completion(creation)
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
    
    func comment(id: String, completion: @escaping(_ result: CommentModel?) -> Void) {
        Amplify.API.query(request: .get(CommentModel.self, byId: id)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let comment):
                    guard let comment = comment else {
                        print("Could not find comment")
                        completion(nil)
                        return
                    }
                    print("Successfully retrieved comment: \(comment)")
                    completion(comment)
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
    
    func like(id: String, completion: @escaping(_ result: LikeModel?) -> Void) {
        Amplify.API.query(request: .get(LikeModel.self, byId: id)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let like):
                    guard let like = like else {
                        print("Could not find like")
                        completion(nil)
                        return
                    }
                    print("Successfully retrieved like: \(like)")
                    completion(like)
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
