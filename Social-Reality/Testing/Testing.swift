//
//  Testing.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/12/21.
//

import Foundation

struct Testing {
    
    static var defaultUser: UserModel {
        
        let model = UserModel(id: "testuser", username: "testuser", status: "ACTIVE", first: "Test", last: "User", lastActive: "", email: "tester@user.com", image: "", access: .public, fcmToken: "")
        
        return model
    }
    
    static var defaultCreation: CreationModel {
        
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
        
        
        return model
    }
    
    static var defaultCreations: [CreationModel] = {
        
        var videos = ["https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_1387.mp4?alt=media&token=64054925-f210-45e1-9cfc-b92a76bd283d",
                      "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2Fglipmovie.mp4?alt=media&token=1782b57f-d750-41e9-b11b-5179131d1613",
                      "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_5025.mp4?alt=media&token=4b9b3195-5748-4cdc-81c0-01d83332f752",
                      "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_1776.mp4?alt=media&token=c465cbf9-0037-48f6-be4d-7b473f9e859b",
                      "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_2742.mp4?alt=media&token=fba574a4-9297-485f-8e7a-794f1d639401"
        ]
        
        var creates = [CreationModel]()
        
        var model1 = CreationModel(id: "model1", title: "Walk in Crested Butte", description: "A beautiful walk through a pristine forest #soreel", lastViewed: "", accessibility: .public, status: "ACTIVE", date: Date().rawDateString, userID: Auth0.uid, userName: "emvalencia", userImage: "", videoURL: "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_1387.mp4?alt=media&token=64054925-f210-45e1-9cfc-b92a76bd283d",
                                   thumbnail: "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/images%2Fthumbnails%2Fmodel1?alt=media&token=2a929da3-742d-44d7-814f-d93323ca2cf8")
        
        var model2 = CreationModel(id: "model2", title: "Backflip in Mykonos", description: "Keating doing a backflip during a sunset in the Greek Islands #soreel", lastViewed: "", accessibility: .public, status: "", date: Date().rawDateString, userID: Testing.defaultUser.id, userName: "keating", userImage: "", videoURL: "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2Fglipmovie.mp4?alt=media&token=1782b57f-d750-41e9-b11b-5179131d1613", thumbnail: "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/images%2Fthumbnails%2Fmodel2?alt=media&token=6c0b85dc-46a2-44f8-9328-37b36570fb6e")
        
        var model3 = CreationModel(id: "model3", title: "ARTECHOUSE", description: "Super cool light show in the Chelsea Market #NYC #soreel", lastViewed: "", accessibility: .public, status: "", date: Date().rawDateString, userID: Testing.defaultUser.id, userName: "emvalencia", userImage: "", videoURL: "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_5025.mp4?alt=media&token=4b9b3195-5748-4cdc-81c0-01d83332f752", thumbnail: "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/images%2Fthumbnails%2Fmodel3?alt=media&token=9672c5c7-f4d0-47d1-8ae2-ce0d8b575c79")
        
        var model4 = CreationModel(id: "model4", title: "Bryce National Park", description: "Ancient walkway in a National Park #soreel", lastViewed: "", accessibility: .public, status: "", date: Date().rawDateString, userID: Testing.defaultUser.id, userName: "traveler", userImage: "", videoURL: "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_1776.mp4?alt=media&token=c465cbf9-0037-48f6-be4d-7b473f9e859b", thumbnail: "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/images%2Fthumbnails%2Fmodel4?alt=media&token=9c73b142-d6b2-4611-adca-7ea142ef8a21")
        
        var model5 = CreationModel(id: "model5", title: "Wake Boarding in NH", description: "Shreddddd It brooooo! #soreel", lastViewed: "", accessibility: .public, status: "", date: Date().rawDateString, userID: Auth0.uid, userName: "nickcrews", userImage: "", videoURL: "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_2742.mp4?alt=media&token=fba574a4-9297-485f-8e7a-794f1d639401", thumbnail: "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/images%2Fthumbnails%2Fmodel5?alt=media&token=b32a6a49-5039-4f24-bf40-41276663b5a9")
        
        creates.append(model1)
        creates.append(model2)
        creates.append(model3)
        creates.append(model4)
        creates.append(model5)
        
        return creates
    }()
    
    static func postDefaultCreation() {
        
        
        let model = CreationModel(id: "abcdefg", title: "The Default Creation", description: "The first testing creation used everywhere #soreel", lastViewed: "", accessibility: .public, status: "ACTIVE", date: Date().rawDateString, userID: "", userName: "ncrews35", userImage: "", videoURL: "https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_1387.mp4?alt=media&token=64054925-f210-45e1-9cfc-b92a76bd283d")
        
        
        
        
        // https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_1776.mp4?alt=media&token=c465cbf9-0037-48f6-be4d-7b473f9e859b
        
        // https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_5025.mp4?alt=media&token=4b9b3195-5748-4cdc-81c0-01d83332f752
        
        // https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2Fglipmovie.mp4?alt=media&token=1782b57f-d750-41e9-b11b-5179131d1613
        
        // https://firebasestorage.googleapis.com/v0/b/social-reality-306200.appspot.com/o/videos%2FIMG_1387.mp4?alt=media&token=64054925-f210-45e1-9cfc-b92a76bd283d
        
        Query.remote.write.creation(model) { res in
            print(res)
        }
        
    }
    
}
