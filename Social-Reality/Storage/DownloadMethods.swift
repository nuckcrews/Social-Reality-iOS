//
//  DownloadMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/8/21.
//

import Foundation
import Amplify
import AmplifyPlugins

struct DownloadMethods {
    
    func imageURL(key: String, completion: @escaping(_ result: URL?) -> Void) {
        Amplify.Storage.getURL(key: key) { event in
            switch event {
            case let .success(url):
                print("Completed: \(url)")
                completion(url)
            case let .failure(storageError):
                print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                completion(nil)
            }
        }
    }
    
}
