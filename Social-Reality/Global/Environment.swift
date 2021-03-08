//
//  Environment.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import Foundation




final class UserData: ObservableObject {
    @Published var isSignedIn : Bool = false
}

final class Environment {
    
    public var env = "dev"
    
    init(id: String) {
        env = id 
    }
    
}

