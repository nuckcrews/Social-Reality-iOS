//
//  Environment.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import Foundation

struct Environment {
    
    static var env = Environments.dev.rawValue
    static var dbs = Databases.dbs.rawValue

    enum Databases: String {
        case dbs
    }

    enum Environments: String {
        case dev
        case staging
        case prod
    }
    
}

struct ProfileImage {
    static var defaultURL = "" // UPDATE
}


