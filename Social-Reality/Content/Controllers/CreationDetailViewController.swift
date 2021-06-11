//
//  CreationDetailViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/18/21.
//

import UIKit
import AVKit

// MARK: - Creation Detail View Controller

class CreationDetailViewController: UIViewController {
    
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
    
    // MARK: - View Instantiation
    
    internal static func instantiate() -> CreationDetailViewController? {

        guard let viewController = Storyboard.CreationDetailViewController.instantiate(CreationDetailViewController.self) else {
            return nil
        }
        
        return viewController
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCreation()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        creationAVPlayerView.playCreation()
        
    }
    
    // MARK: - Creation Fetching
    
    func getCreation() {
        
        creation = Testing.defaultCreation
        
        setupView()
        
    }
    
    // MARK: - View Setup
    
    func setupView() {
        
        guard let creation = creation else { return }
        
        creatorAvatarImage.setImageFromURL(creation.userImage ?? "")
        creationTitleLabel.text = creation.title
        creationDescriptionLabel.text = creation.description
        let date = creation.date?.rawDate
        creationTimeLabel.text = date?.currentDistance(to: Date())
        
        creationAVPlayerView.delegate = self
        creationAVPlayerView.setupVideo(url: creation.videoURL)
        
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
    
    @IBAction func tapVolume(_ sender: UIButton) {
        sender.jump()
        
        
        
    }
    
    @IBAction func tapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

// MARK: - CreationAVPlayer Delegate

extension CreationDetailViewController: CreationAVPlayerDelegate {
    
    func doubleTappedVideo() {
        likeButton.tintColor = .primary
        likeButton.backgroundColor = .background
    }
    
}
