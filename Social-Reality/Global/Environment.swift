//
//  Environment.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import Foundation
import UIKit

struct Environment {
    
    static var env = Environments.dev.rawValue
    static var dbs = Databases.dbs.rawValue
    
    static var topSafeAreaHeight: CGFloat {
        let window = UIApplication.shared.windows[0]
        let safeFrame = window.safeAreaLayoutGuide.layoutFrame
        return safeFrame.minY
    }
    
    static var bottomSafeAreaHeight: CGFloat {
        let window = UIApplication.shared.windows[0]
        let safeFrame = window.safeAreaLayoutGuide.layoutFrame
        return window.frame.maxY - safeFrame.maxY
    }

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
    
    static var defaultUser: User {
        
        let model = UserModel(id: "testuser", username: "testuser", status: "ACTIVE", first: "Test", last: "User", lastActive: "", email: "tester@user.com", image: "", access: .public, fcmToken: "")
        
        let user = User(model: model)
        
        return user
    }
    
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
