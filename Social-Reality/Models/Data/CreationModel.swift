//
//  CreationModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/18/21.
//

import Foundation

struct CreationModel: Codable, Equatable {
    
    public let id: String
    public var title: String
    public var description: String?
    public var lastViewed: String?
    public var accessibility: CreationAccessibility
    public var status: String
    public var date: String?
    public var userID: String?
    public var userName: String?
    public var userImage: String?
    public var videoURL: String?
    public var thumbnail: String?
    
}

extension CreationModel {
    
    mutating func update(data: [String: Any]) {
        
        for item in data {
            
            if item.key == Fields.creation.title.rawValue,
               let value = item.value as? String {
                title = value
            }
            
            if item.key == Fields.creation.description.rawValue,
               let value = item.value as? String {
                description = value
            }
            
            if item.key == Fields.creation.lastViewed.rawValue,
               let value = item.value as? String {
                lastViewed = value
            }
            
            if item.key == Fields.creation.accessibility.rawValue,
               let value = item.value as? CreationAccessibility {
                accessibility = value
            }
            
            if item.key == Fields.creation.status.rawValue,
               let value = item.value as? String {
                status = value
            }
            
            if item.key == Fields.creation.date.rawValue,
               let value = item.value as? String {
                date = value
            }
            
            if item.key == Fields.creation.userID.rawValue,
               let value = item.value as? String {
                userID = value
            }
            
            if item.key == Fields.creation.userName.rawValue,
               let value = item.value as? String {
                userName = value
            }
            
            if item.key == Fields.creation.videoURL.rawValue,
               let value = item.value as? String {
                videoURL = value
            }
            
            if item.key == Fields.creation.thumbnail.rawValue,
               let value = item.value as? String {
                thumbnail = value
            }
            
        }
        
    }
    
}
