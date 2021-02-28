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
    
}
