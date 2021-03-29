//
//  DownloadMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/8/21.
//

import Foundation
import Firebase

struct DownloadMethods {
    
    func imageURL(key: String, completion: @escaping(_ result: URL?) -> Void) {
        
    }
    
    func video() {
        
        let pathReference = Storage.storage().reference(withPath: "videos/IMG_5025.mp4")
        
        pathReference.downloadURL { url, err in
            print(url)
        }
    }
    
}
