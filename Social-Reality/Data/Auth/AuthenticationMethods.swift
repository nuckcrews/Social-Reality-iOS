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
    

    static func emailExists(email: String, completion: @escaping(_ result: Bool) -> Void) {
        
    }

    static func userExists(email: String, completion: @escaping(_ result: Bool?) -> Void) {
        guard email.isValidEmail() else { completion(nil); return }
        Auth.auth().fetchSignInMethods(forEmail: email) { methods, error in
            if error != nil || methods?.count ?? 0 == 0 {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    static func userDataExists(id: String, completion: @escaping(_ result: Bool) -> Void) {
        Query.get.user(id: id) { model in
            model == nil ? completion(false) : completion(true)
        }
    }
    
    static func usernameExists(username: String, completion: @escaping(_ result: Bool) -> Void) {
        
    }
    
    static func signUp(email: String, password: String, completion: @escaping(_ result: ResultType) -> Void) {
        guard email.isValidEmail() else { completion(.error); return }

    }
    
    static func sendEmailVerification(email: String, completion: @escaping(_ result: ResultType) -> Void) {
        
    }
    
    
    static func signInWithProvider(credential: AuthCredential, completion: @escaping(_ result: AuthDataResult?) -> Void) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil || authResult == nil {
                completion(nil)
            } else {
                completion(authResult)
            }
        }
    }
    
    
    static func signIn(email: String, password: String, completion: @escaping(_ result: ResultType) -> Void) {
        guard email.isValidEmail() else { completion(.error); return }
        
    }
    
    static func signOut(completion: @escaping(_ result: ResultType) -> Void) {
      
    }
    

}
