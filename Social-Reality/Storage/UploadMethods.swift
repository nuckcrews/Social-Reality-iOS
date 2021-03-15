//
//  UploadMethods.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/8/21.
//

import Foundation
import Amplify
import AmplifyPlugins

struct UploadMethods {
    
    func image(key: String, image: UIImage, completion: @escaping(_ result: ResultType) -> Void) {
        if let data = image.jpegData(compressionQuality: 0.6) {
            Amplify.Storage.uploadData(
                key: key,
                data: data,
                progressListener: { progress in
                    print("Progress: \(progress)")
                }, resultListener: { event in
                    switch event {
                    case .success(let data):
                        print("Completed: \(data)")
                        completion(.success)
                    case .failure(let storageError):
                        print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                        completion(.error)
                    }
                }
            )
        } else {
            completion(.error)
        }
    }
    
}
