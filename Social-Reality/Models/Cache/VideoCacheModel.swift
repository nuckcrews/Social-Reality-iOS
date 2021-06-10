//
//  VideoCacheModel.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/31/21.
//

import Foundation
import AVKit

final class VideoCacheModel {
    
    var urlString: String?
    var player: AVQueuePlayer?
    var playerLooper: AVPlayerLooper?
    var playerLayer: AVPlayerLayer?
    
    init?(urlString: String?, player: AVQueuePlayer?, looper: AVPlayerLooper?, layer: AVPlayerLayer?) {
        if let url = URL(string: urlString ?? ""), let player = player, let looper = looper, let layer = layer {
            self.urlString = url.absoluteString
            self.player = player
            self.playerLooper = looper
            self.playerLayer = layer
        } else {
            return nil
        }
    }
    
}
