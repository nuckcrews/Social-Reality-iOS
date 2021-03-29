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

struct Testing {
    
    static var defaultCreation: Creation {
        
        let model = CreationModel(id: "abcdefg",
                                  title: "The Default Creation",
                                  description: "The first testing creation used everywhere #soreel",
                                  lastViewed: "",
                                  accessibility: .public,
                                  status: "ACTIVE",
                                  date: Date().rawDateString,
                                  userID: "",
                                  userName: "ncrews35",
                                  userImage: "",
                                  videoURL: "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_5025.mp4?alt=media&token=4b9b3195-5748-4cdc-81c0-01d83332f752")
        
        
        let creation = Creation(model: model)
        
        return creation
    }
    
    static func postDefaultCreation() {
    
        
        let model = CreationModel(id: "abcdefg", title: "The Default Creation", description: "The first testing creation used everywhere #soreel", lastViewed: "", accessibility: .public, status: "ACTIVE", date: Date().rawDateString, userID: "", userName: "ncrews35", userImage: "", videoURL: "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_5025.mp4?alt=media&token=4b9b3195-5748-4cdc-81c0-01d83332f752")
        
        Query.write.creation(model) { res in
            print(res)
        }
        
    }
    
}
