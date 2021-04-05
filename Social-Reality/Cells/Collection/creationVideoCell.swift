//
//  creationVideoCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/29/21.
//

import UIKit

class creationVideoCell: UICollectionViewCell {
    
    @IBOutlet weak var creationAVPlayerView: CreationAVPlayerView!
    @IBOutlet weak var creatorAvatarImage: UIImageView!
    @IBOutlet weak var creationTitleLabel: UILabel!
    @IBOutlet weak var creationDescriptionLabel: UILabel!
    @IBOutlet weak var creationTechniqueLabel: UILabel!
    @IBOutlet weak var creationTimeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var user: UserModel?
    var creation: CreationModel?
    var presenting = false
    
    func configureCell(_ creationModel: CreationModel?, _ userModel: UserModel?) {
        
        creation = creationModel
        user = userModel
        
        creatorAvatarImage.setImageFromURL(creation?.userImage ?? "")
        creationTitleLabel.text = creation?.title
        creationDescriptionLabel.text = creation?.description
        let date = creation?.date?.rawDate
        creationTimeLabel.text = date?.currentDistance(to: Date())
        
        creationAVPlayerView.delegate = self
        creationAVPlayerView.setupVideo(url: creation?.videoURL)
        
        creationAVPlayerView.frame = bounds
        
    }
    
    func presented() {
        
        creationAVPlayerView.playCreation()
        creationAVPlayerView.frame = bounds
        
        presenting = true
    }
    
    func dismissed() {
        
//        guard presenting else { return }
        
        creationAVPlayerView.pauseCreation()
        presenting = false
//        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { [weak self] _ in
//            if !(self?.presenting ?? true) {
//                self?.creationAVPlayerView.restartCreation()
//            }
//        }
    }
    
    @IBAction func tapLike(_ sender: UIButton) {
        sender.jump()
        Buzz.light()
        
        if sender.tintColor == .primary {
            sender.tintColor = .white
            sender.backgroundColor = UIColor(white: 0, alpha: 0.1)
        } else {
            sender.tintColor = .primary
            sender.backgroundColor = .background
        }
        
    }
    
    @IBAction func tapComment(_ sender: UIButton) {
        sender.jump()
        
        Buzz.light()
        MainToCoverDelegate?.tappedComments(creation: creation)
        
    }
    
    @IBAction func tapShare(_ sender: UIButton) {
        sender.jump()
        Buzz.light()
        
        MainToCoverDelegate?.tappedSendCreation(creation: creation)
    }
    
    @IBAction func tapPausePlay(_ sender: UIButton) {
        
        creationAVPlayerView.playing ?
            creationAVPlayerView.pauseCreation() :
            creationAVPlayerView.playCreation()
        
    }
    
}

extension creationVideoCell: CreationAVPlayerDelegate {
    
    func doubleTappedVideo() {
        likeButton.tintColor = .primary
        likeButton.backgroundColor = .background
    }
    
}
