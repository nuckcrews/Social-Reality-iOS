//
//  CreationVideoCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/29/21.
//

import UIKit
import Firebase
import FirebaseFirestore

// MARK: - Creation Video Cell

class CreationVideoCell: UITableViewCell {
    
    // MARK: - Identifiers
    
    enum identifiers: String {
        case creationVideoCell
    }
    
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
    var creationData: CreationData?
    var presenting = false
    var likeID: String?
    var likeLstn: ListenerRegistration?
    var likesCreation = false {
        didSet {
            if likesCreation {
                likeButton.tintColor = .primary
                likeButton.backgroundColor = .background
            } else {
                likeButton.tintColor = .white
                likeButton.backgroundColor = UIColor(white: 0, alpha: 0.1)
            }
        }
    }
    
    // MARK: - Cell Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        likeButton.tintColor = .white
//        likeButton.backgroundColor = UIColor(white: 0, alpha: 0.1)
        
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
    
    // MARK: - Get Data
    
    func getData() {
        
        guard let creation = creation, let uid = Auth0.uid, likeLstn == nil else { return }
        
        Query.remote.subscribe.userLikedWithPredicate(userID: uid, field: Fields.like.creationID.rawValue, value: creation.id) { [weak self] models, lstn in
            self?.likesCreation = models?.count ?? 0 > 0
            self?.likeLstn = lstn
        }
        
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
        
        getData()
        
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
    
    func likeCreation() {
        if likeID == nil {
            likeID = UUID().uuidString
        }
        guard let likeID = likeID else {
            return
        }
        let likeModel = UserLikeModel(id: likeID,
                                      creationID: creation?.id ?? "",
                                      thumbnail: creation?.thumbnail ?? "",
                                      userID: Auth0.uid ?? "",
                                      userImage: user?.id ?? "")
        
        if !likesCreation {
            Query.remote.write.userLike(likeModel) { result in
                switch result {
                case .success:
                    print("Success liking")
                case .error:
                    print("Error liking")
                }
            }
        } else {
            Query.remote.delete.like(likeID) { result in
                switch result {
                case .success:
                    print("Success disliking")
                case .error:
                    print("Error disliking")
                }
            }
        }
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
        
        likeCreation()
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

extension CreationVideoCell: CreationAVPlayerDelegate {
    
    func doubleTappedVideo() {
        
        Buzz.light()
        likeCreation()
        if likeButton.tintColor == .primary {
            likeButton.tintColor = .white
            likeButton.backgroundColor = UIColor(white: 0, alpha: 0.1)
        } else {
            likeButton.tintColor = .primary
            likeButton.backgroundColor = .background
        }
        
    }
    
}
