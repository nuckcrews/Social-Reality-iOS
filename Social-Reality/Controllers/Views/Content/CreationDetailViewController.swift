//
//  CreationDetailViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/18/21.
//

import UIKit
import AVKit

class CreationDetailViewController: UIViewController {

    @IBOutlet weak var creationAVPlayerView: UIView!
    @IBOutlet weak var creatorAvatarImage: UIImageView!
    @IBOutlet weak var creationTitleLabel: UILabel!
    @IBOutlet weak var creationDescriptionLabel: UILabel!
    @IBOutlet weak var creationTechniqueLabel: UILabel!
    @IBOutlet weak var creationTimeLabel: UILabel!
    
    var user: User?
    var creation: Creation?
//    var player = CreationAVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCreation()
        
    }
    
    func getCreation() {
        
        creation = Testing.defaultCreation
        
        setupView()
        
    }
    
    func setupView() {
        
//        creationAVPlayerView.addSubview(player)
        
        guard let creation = creation else { return }
        
        creatorAvatarImage.setImageFromURL(creation.model?.userImage ?? "")
        creationTitleLabel.text = creation.model?.title
        creationDescriptionLabel.text = creation.model?.description
        let date = creation.model?.date?.rawDate
        creationTimeLabel.text = date?.currentDistance(to: Date())
        
    }
    
    @IBAction func tapLike(_ sender: UIButton) {
        sender.jump()
        Buzz.light()
    }
    
    @IBAction func tapComment(_ sender: UIButton) {
        sender.jump()
        
        Buzz.light()
        MainToCoverDelegate?.tappedComments(creation: creation?.model)
        
    }
    
    @IBAction func tapShare(_ sender: UIButton) {
        sender.jump()
        Buzz.light()
        
    }
    
    @IBAction func tapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }

}
