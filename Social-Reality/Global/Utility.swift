//
//  Utility.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/15/21.
//

import Foundation
import UIKit
import Amplify
import AmplifyPlugins

func uploadImage() {
    Storage.upload.image(key: "defaultprofile", image: UIImage(named: "DefaultProfileImage")!) { (result) in
        Storage.download.imageURL(key: "defaultprofile") { (url) in
            print(url?.absoluteString as Any)
        }
    }
}
