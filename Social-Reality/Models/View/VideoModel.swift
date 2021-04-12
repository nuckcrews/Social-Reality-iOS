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
    
    static func getThumbnailImage(forUrl str: String?) -> UIImage? {
        
        guard let url = URL(string: str ?? "") else { return nil }
        
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }

        return nil
    }
    
}
