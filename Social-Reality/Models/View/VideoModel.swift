//
//  VideoModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/12/21.
//

import Foundation
import UIKit
import AVFoundation

struct VideoModel {
    
    static func getThumbnailImage(forUrl str: String?, completion: @escaping(_ result: UIImage?) -> Void){
        DispatchQueue.global().async {
            guard let url = URL(string: str ?? "") else { completion(nil); return }
            
            let asset: AVAsset = AVAsset(url: url)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            
            do {
                let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
                
                completion(UIImage(cgImage: thumbnailImage))
                return
            } catch let error {
                print(error)
                completion(nil)
            }
            
            completion(nil)
        }
    }
    
}
