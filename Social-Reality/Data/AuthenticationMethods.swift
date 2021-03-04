//
//  AuthenticationMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import Foundation
import Amplify
import AmplifyPlugins
import GoogleSignIn
import FBSDKLoginKit
import AWSGoogleSignIn
import AWSUserPoolsSignIn
import GTMAppAuth
import AppAuth
import AuthenticationServices

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
    
    func confirmSignUp(for username: String, with confirmationCode: String, completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case .success:
                print("Confirm signUp succeeded")
                completion(.success)
            case .failure(let error):
                print("An error occurred while confirming sign up \(error)")
                completion(.error)
            }
        }
    }
    
    
//    func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
//        if error != nil {
//          print(error.localizedDescription)
//        }
//        else {
//          let idToken = auth.parameters.objectForKey("id_token")
//          credentialsProvider.logins = [AWSCognitoLoginProviderKey.Google.rawValue: idToken!]
//        }
//    }

    func signInWithProvider(provider: AuthProvider, window: UIWindow, completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.Auth.signInWithWebUI(for: provider, presentationAnchor: window, options: nil) { result in
            print(result)
            completion(.success)
        }
        
        
    }
    
    func signInWithFacebook(loginButton: FBLoginButton) {
        loginButton.sendActions(for: .touchUpInside)
    }
    
    func signInWithGoogle(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                          withError error: Error!, completion: @escaping(_ result: [String: Any]?) -> Void) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        completion(nil)
        return
      }
      // Perform any operations on signed in user here.
      let userId = user.userID                  // For client-side use only!
      let idToken = user.authentication.idToken // Safe to send to the server
      let fullName = user.profile.name
      let givenName = user.profile.givenName
      let familyName = user.profile.familyName
      let email = user.profile.email
        completion(nil) // FIX THIS
      // ...
    }
    
    func signOutGoogle() {
        GIDSignIn.sharedInstance().signOut()
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
    
    func rememberDevice(completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.Auth.rememberDevice() { result in
            switch result {
            case .success:
                print("Remember device succeeded")
                completion(.success)
            case .failure(let error):
                print("Remember device failed with error \(error)")
                completion(.error)
            }
        }
    }
    
    func forgetDevice(completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.Auth.forgetDevice() { result in
            switch result {
            case .success:
                print("Forget device succeeded")
                completion(.success)
            case .failure(let error):
                print("Forget device failed with error \(error)")
                completion(.error)
            }
        }
    }
    
    func fetchDevices(completion: @escaping(_ result: [AuthDevice]?) -> Void) {
        Amplify.Auth.fetchDevices() { result in
            switch result {
            case .success(let fetchDeviceResult):
                for device in fetchDeviceResult {
                    print(device.id)
                }
                completion(fetchDeviceResult)
            case .failure(let error):
                print("Fetch devices failed with error \(error)")
                completion(nil)
            }
        }
    }
    
    func signOutLocally(completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.Auth.signOut() { result in
            switch result {
            case .success:
                print("Successfully signed out")
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }
    
    func signOutGloball(completion: @escaping(_ result: ResultType) -> Void) {
        Amplify.Auth.signOut(options: .init(globalSignOut: true)) { result in
            switch result {
            case .success:
                print("Successfully signed out")
                completion(.success)
            case .failure(let error):
                print("Sign out failed with error \(error)")
                completion(.error)
            }
        }
    }
    
}
