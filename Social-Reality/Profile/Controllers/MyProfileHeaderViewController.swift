//
//  MyProfileHeaderViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/14/21.
//

import UIKit

class MyProfileHeaderViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberOfFollowersLabel: UILabel!
    @IBOutlet var numberOfFollowingLabel: UILabel!
    @IBOutlet var numberOfLikesLabel: UILabel!
    
    var userID: String?
    var user: UserModel?
    
    var titleInitialCenterY: CGFloat!
    var covernitialCenterY: CGFloat!
    var covernitialHeight: CGFloat!
    var lastProgress: CGFloat = .zero
    var lastMinHeaderHeight: CGFloat = .zero
    
    struct FollowData {
        static var followers = 0
        static var following = 0
        static var likes = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUser()
        
    }
    
    func getUser() {
        
        print("getting the user")
        
        guard let userID = userID else { return }
        
        Query.subscribe.user(userID) { [weak self] model, lstn in
            self?.user = model
            self?.setupView()
        }
        
    }
    
    func setupView() {
        
        guard let user = user else { return }
        
        avatarImageView.setImageFromURL(user.image)
        nameLabel.text = user.last.count > 0 ? "\(user.first) \(user.last)" : user.first
        numberOfFollowersLabel.text = String(FollowData.followers)
        numberOfFollowingLabel.text = String(FollowData.following)
        numberOfLikesLabel.text = String(FollowData.likes)
        
    }
    
    func update(with progress: CGFloat, minHeaderHeight: CGFloat){
            lastProgress = progress
            lastMinHeaderHeight = minHeaderHeight
            
            let y = progress * (view.frame.height - minHeaderHeight)
            
            guard covernitialHeight != nil else {
                return
            }
            
            
        }
    
    
    func toEditProfile() {
//        DispatchQueue.main.async {
//            self.performSegue(withIdentifier: Segue.toEditProfileFromAccount.rawValue, sender: nil)
//        }
        Navigation.modal(to: .EditProfileViewController, navigationController: navigationController, data: nil, style: .pageSheet)
    }
    
    @IBAction func tapEditProfile(_ sender: UIButton) {
        
        sender.jump()
        toEditProfile()
        
    }
    

}
