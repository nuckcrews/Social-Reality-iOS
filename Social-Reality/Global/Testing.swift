//
//  Testing.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/12/21.
//

import Foundation

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
                                  videoURL:
                                    "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_1387.mp4?alt=media&token=64054925-f210-45e1-9cfc-b92a76bd283d")
                                    
        // https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_5025.mp4?alt=media&token=4b9b3195-5748-4cdc-81c0-01d83332f752
        // https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_1387.mp4?alt=media&token=64054925-f210-45e1-9cfc-b92a76bd283d
        
        
        let creation = Creation(model: model)
        
        return creation
    }
    
    static var defaultCreations: [CreationModel] = {
        
        var videos = ["https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_1387.mp4?alt=media&token=64054925-f210-45e1-9cfc-b92a76bd283d",
                      "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2Fglipmovie.mp4?alt=media&token=1782b57f-d750-41e9-b11b-5179131d1613",
        "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_5025.mp4?alt=media&token=4b9b3195-5748-4cdc-81c0-01d83332f752",
        "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_1776.mp4?alt=media&token=c465cbf9-0037-48f6-be4d-7b473f9e859b",
        "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_2742.mp4?alt=media&token=fba574a4-9297-485f-8e7a-794f1d639401"
        ]
        
        var creates = [CreationModel]()
        
        var model = CreationModel(id: "abcdefg", title: "The Default Creation", description: "The first testing creation used everywhere #soreel", lastViewed: "", accessibility: .public, status: "ACTIVE", date: Date().rawDateString, userID: "", userName: "ncrews35", userImage: "", videoURL: "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_1387.mp4?alt=media&token=64054925-f210-45e1-9cfc-b92a76bd283d")
        
        for i in 0..<5 {
            model.videoURL = videos[i]
            creates.append(model)
        }
        
       return creates
    }()
    
    static func postDefaultCreation() {
    
        
        let model = CreationModel(id: "abcdefg", title: "The Default Creation", description: "The first testing creation used everywhere #soreel", lastViewed: "", accessibility: .public, status: "ACTIVE", date: Date().rawDateString, userID: "", userName: "ncrews35", userImage: "", videoURL: "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_1387.mp4?alt=media&token=64054925-f210-45e1-9cfc-b92a76bd283d")
        

        
        
        // https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_1776.mp4?alt=media&token=c465cbf9-0037-48f6-be4d-7b473f9e859b
                                    
        // https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_5025.mp4?alt=media&token=4b9b3195-5748-4cdc-81c0-01d83332f752
        
        // https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2Fglipmovie.mp4?alt=media&token=1782b57f-d750-41e9-b11b-5179131d1613
        
        // https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_1387.mp4?alt=media&token=64054925-f210-45e1-9cfc-b92a76bd283d
        
        Query.write.creation(model) { res in
            print(res)
        }
        
    }
    
}
