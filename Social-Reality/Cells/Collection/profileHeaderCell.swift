//
//  ProfileHeaderCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/2/21.
//

import UIKit

class ProfileHeaderCell: UICollectionViewCell {

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var numberOfPostsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        avatarImageView.layer.borderWidth = 1
    }
    
    func configure(with data: ProfileHeaderData) {
        nameLabel.text = data.username
        numberOfPostsLabel.text = String(data.postCount)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height/2
    }

}
