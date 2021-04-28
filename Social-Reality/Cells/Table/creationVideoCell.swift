//
//  creationVideoCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/29/21.
//

import UIKit

// MARK: - Creation Video Cell

class creationVideoCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var creationAVPlayerView: CreationAVPlayerView!
    @IBOutlet weak var creatorAvatarImage: UIImageView!
    @IBOutlet weak var creationTitleLabel: UILabel!
    @IBOutlet weak var creationDescriptionLabel: UILabel!
    @IBOutlet weak var creationTechniqueLabel: UILabel!
    @IBOutlet weak var creationTimeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    // MARK: - Variables
    
    var user: UserModel?
    var creation: CreationModel?
    var presenting = false
    
    // MARK: - Cell Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        likeButton.tintColor = .white
        likeButton.backgroundColor = UIColor(white: 0, alpha: 0.1)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        creationAVPlayerView.frame = bounds
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Configure Methods
    
    func configureCell(_ creationModel: CreationModel?, _ userModel: UserModel?) {
        
        creationAVPlayerView.translatesAutoresizingMaskIntoConstraints = false
        
        creation = creationModel
        user = userModel
        
        creatorAvatarImage.setImageFromURL(creation?.userImage ?? "")
        creationTitleLabel.text = "@" + (creation?.userName ?? "username")
        creationDescriptionLabel.text = creation?.description
        let date = creation?.date?.rawDate
        creationTimeLabel.text = date?.currentDistance(to: Date())
        
        creationAVPlayerView.delegate = self
        
        creationAVPlayerView.adjustedFrame = bounds
        creationAVPlayerView.frame = bounds
        
        
        creationAVPlayerView.setupVideo(url: creation?.videoURL, starterURL: creation?.thumbnail)
        
        
        
    }
    
    func presented() {
        
        creationAVPlayerView.translatesAutoresizingMaskIntoConstraints = false
        creationAVPlayerView.playCreation()
        creationAVPlayerView.frame = bounds
        
        creationAVPlayerView.adjustedFrame = bounds
        
        presenting = true
    }
    
    func dismissed() {
        
        creationAVPlayerView.pauseCreation()
        presenting = false
        
    }
    
    // MARK: - Action Outlets
    
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

// MARK: - Creation AV Player Delegate

extension creationVideoCell: CreationAVPlayerDelegate {
    
    func doubleTappedVideo() {
        likeButton.tintColor = .primary
        likeButton.backgroundColor = .background
    }
    
}
