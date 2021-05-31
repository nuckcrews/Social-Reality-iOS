//
//  ProfileHeaderCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/2/21.
//

import UIKit

class profileHeaderCell: UICollectionViewCell {

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberOfFollowersLabel: UILabel!
    @IBOutlet var numberOfFollowingLabel: UILabel!
    @IBOutlet var numberOfLikesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        avatarImageView.layer.borderWidth = 1
        
    }
    
    func configure(with data: ProfileHeaderData) {
        
        avatarImageView.setImageFromURL(data.image)
        nameLabel.text = data.last.count > 0 ? "\(data.first) \(data.last)" : data.first
        numberOfFollowersLabel.text = String(data.followerCount)
        numberOfFollowingLabel.text = String(data.followingCount)
        numberOfLikesLabel.text = String(data.likesCount)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}
