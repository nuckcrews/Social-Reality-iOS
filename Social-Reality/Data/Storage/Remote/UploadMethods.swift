//
//  UploadMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/8/21.
//

import Foundation
import UIKit
import AVKit
import Firebase
import FirebaseStorage

struct UploadMethods {
    
    func image(key: String, image: UIImage, completion: @escaping(_ result: String?) -> Void) {
        let ref = Storage.storage().reference().child(key)
        if let data = image.jpegData(compressionQuality: 0.6) {
            ref.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    completion(nil)
                } else {
                    ref.downloadURL { (url, error) in
                        completion(url?.absoluteString)
                    }
                }
            }
        }
        
    }
    
    func video(key: String, video: Data, completion: @escaping(_ result: String?) -> Void) {
        let ref = Storage.storage().reference().child(key)
        ref.putData(video, metadata: nil) { (metadata, error) in
            guard error == nil else { completion(nil); return }
            ref.downloadURL { (url, error) in
                completion(url?.absoluteString)
            }
        }
    }
    
}
