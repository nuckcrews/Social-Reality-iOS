//
//  AuthenticationMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import Foundation
import Amplify
import AmplifyPlugins

struct Auth {
    
    var signedIn: Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.userData.isSignedIn
    }
    
    func checkSessionStatus(completion: @escaping(_ result: Bool) -> Void) {
        _ = Amplify.Auth.fetchAuthSession { result in
            switch result {
            case .success(let session):
                print("Is user signed in - \(session.isSignedIn)")
                completion(session.isSignedIn)
            case .failure(let error):
                print("Fetch session failed with error \(error)")
                
                completion(false)
            }
        }
    }
    
    func signInWithEmail(email: String, password: String, completion: @escaping(_ result: ResultType) -> Void) {
        if email.isValidEmail() {
            
        }
        
        
    }
    
    func userExists(email: String, completion: @escaping(_ result: Bool?) -> Void) {
        guard email.isValidEmail() else {
            completion(nil)
            return
        }
        completion(false) // Fix this
        
    }
    
    func signUp(username: String, password: String, email: String, completion: @escaping(_ result: ResultType) -> Void) {
        guard email.isValidEmail() && password != "" else {
            completion(.error)
            return
        }
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: username, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                    completion(.success)
                } else {
                    print("SignUp Complete")
                    completion(.success)
                }
            case .failure(let error):
                completion(.success)
                print("An error occurred while registering a user \(error)")
            }
        }
    }
    
    func signIn(username: String, password: String, completion: @escaping(_ result: ResultType) -> Void) {
        guard username != "" else {
            completion(.error)
            return
        }
        Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            case .success:
                print("Sign in succeeded")
                completion(.success)
            case .failure(let error):
                print("Sign in failed \(error)")
                completion(.error)
            }
        }
    }
    
    
}
