//
//  AuthenticationMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

// MARK: Authentication Methods - Global

struct Auth0 {
    
    static var loggedIn: Bool {
        return Auth.auth().currentUser?.uid != nil
    }
    
    static var uid: String? {
        return Auth.auth().currentUser?.uid
    }
    
    enum status: String {
        case active = "ACTIVE"
        case deleted = "DELETED"
        case inactive = "INACTIVE"
    }
    
    static func userExists(email: String, completion: @escaping (Bool?) -> Void) {
        guard email.isValidEmail() else { completion(nil); return }
        Auth.auth().fetchSignInMethods(forEmail: email) { methods, error in
            if error != nil || methods?.count ?? 0 == 0 {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    static func userDataExists(id: String, completion: @escaping (Bool) -> Void) {
        Query.remote.get.user(id) { model in
            completion(model != nil)
        }
    }
    
    static func usernameExists(username: String, completion: @escaping (Bool) -> Void) {
        Query.remote.get.usersWithPredicate(field: Fields.user.username.rawValue, value: username) { models in
            completion(models?.count ?? 0 > 0)
        }
    }
    
    static func signUp(email: String, password: String, completion: @escaping (AuthDataResult?) -> Void) {
        guard email.isValidEmail(), password.isValidPassword() else { completion(nil); return }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil || authResult == nil {
                completion(nil)
            } else {
                completion(authResult)
            }
        }
    }
    
    static func sendEmailVerification(email: String, completion: @escaping (ResultType) -> Void) {
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            error == nil ? completion(.success) : completion(.error)
        })
    }
    
    static func signInWithProvider(credential: AuthCredential, completion: @escaping (AuthDataResult?) -> Void) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil || authResult == nil {
                completion(nil)
            } else {
                completion(authResult)
            }
        }
    }
    
    
    static func signIn(email: String, password: String, completion: @escaping (AuthDataResult?) -> Void) {
        guard email.isValidEmail() else { completion(nil); return }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil || authResult == nil {
                completion(nil)
            } else {
                completion(authResult)
            }
        }
    }
    
    static func signOut(completion: @escaping (ResultType) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let loginManager = LoginManager()
            loginManager.logOut()
            completion(.success)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            completion(.error)
        }
    }
    
    
}
