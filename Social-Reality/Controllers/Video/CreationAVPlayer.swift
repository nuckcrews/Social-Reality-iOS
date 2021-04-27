//
//  CreationAVPlayer.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/18/21.
//

import UIKit
import AVKit

// MARK: - Creation AV PLayer View - Utility

class CreationAVPlayerView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var centerIndicator: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var starterImageView: UIImageView!
    
    // MARK: - Variables
    
    private var urlString: String?
    private var player: AVQueuePlayer?
    private var playerLooper: AVPlayerLooper?
    private var playerLayer: AVPlayerLayer?
    
    private var playerObserver: NSKeyValueObservation?
    
    var adjustedFrame: CGRect?
    
    var playing = false
    private var muted = false
    private var setup = false
    
    weak var delegate: CreationAVPlayerDelegate?
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        frame = adjustedFrame != nil ? adjustedFrame! : frame
        
    }
    
    // MARK: - Video Setup
    
    func setupVideo(url: String?, starterURL: String? = nil) {
        
        playerObserver?.invalidate()
        
        starterImageView.image = nil
        starterImageView.alpha = 0
        
        if player != nil && urlString == url {
            starterImageView.image = nil
            starterImageView.alpha = 0
            self.restartCreation()
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers])
        } catch {
            print("no audio ")
        }
        
        centerIndicator.alpha = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTouchesRequired = 1
        doubleTap.numberOfTapsRequired = 2
        
        tap.require(toFail: doubleTap)
        tap.delaysTouchesBegan = true
        doubleTap.delaysTouchesBegan = true
        
        addGestureRecognizer(tap)
        addGestureRecognizer(doubleTap)
        
        playerLayer?.removeFromSuperlayer()
        player = nil
        playerLayer = nil
        
        urlString = url
        
        guard let url = URL(string: url ?? "") else { return }
        
        print("got asset", url.absoluteString)
        
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        player = AVQueuePlayer(playerItem: playerItem)
        player?.isMuted = Device.isMuted
        
        if let _ = URL(string: starterURL ?? "") {
//            starterImageView.setImageFromURL(starterURL)
//            starterImageView.alpha = 1
        } else {
            starterImageView.image = nil
            starterImageView.alpha = 0
        }
        
        guard let player = player else { return }
        
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = bounds
        playerLayer?.videoGravity = .resizeAspectFill
        
        guard let playerLayer = playerLayer else { return }
        
        layer.addSublayer(playerLayer)
        
        loadingIndicator.alpha = 1
        loadingIndicator.startAnimating()
        
        bringSubviewToFront(centerIndicator)

        frame = adjustedFrame != nil ? adjustedFrame! : frame
        setup = true
        
        playerObserver = playerItem.observe(\.status, options:  [.new, .old], changeHandler: { [weak self] (playerItem, change) in
                if playerItem.status == .readyToPlay {
                    self?.starterImageView.alpha = 0
                    self?.starterImageView.image = nil
                }
            })
        
    }
    
    // MARK: - User Interactions
    
    @objc func tapped() {
        
        if playing {
            pauseCreation(); animateCenter(image: "pause.fill")
        } else {
            playCreation(); animateCenter(image: "play.fill")
        }
        
    }
    
    @objc func doubleTapped() {
        Buzz.light()
        
        delegate?.doubleTappedVideo()
        animateCenter(image: "heart.fill")
    }
    
    func animateCenter(image: String) {
        centerIndicator.image = UIImage(systemName: image)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.centerIndicator.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                self.centerIndicator.alpha = 0
            } completion: { _ in }
        }
        
    }
    
    // MARK: - Video Methods
    
    func playCreation() {
        mainVolumeDelegate = self
        player?.isMuted = Device.isMuted
        
        player?.play()
        playing = true
        print("playing")
    }
    
    func restartCreation() {
        
        mainVolumeDelegate = self
        player?.isMuted = Device.isMuted
        
        player?.seek(to: .zero) { [weak self] _ in
            self?.player?.play()
            self?.player?.rate = 1
            self?.player?.isMuted = Device.isMuted
        }
        
        playing = false
        
        print("restarted")
    }
    
    
    func pauseCreation() {
        player?.pause()
        playing = false
        print("pausing")
    }
    
}

// MARK: - Volume Delegate

extension CreationAVPlayerView: MainVolumeDelegate {
    
    func changeVolume() {
        player?.isMuted = Device.isMuted
    }
    
}
