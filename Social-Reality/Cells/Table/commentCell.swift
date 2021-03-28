//
//  commentCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/26/21.
//

import UIKit

class commentCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var liked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(comment: CommentModel, liked: Bool?) {
        
        userImageView.setImageFromURL(comment.userImage ?? "")
        userNameLabel.text = comment.userName
        commentLabel.text = comment.content
        dateLabel.text = comment.date?.rawDate?.currentDistance(to: Date())
        
    }
    
    @IBAction func tapLikeButton(_ sender: UIButton) {
        
        sender.jump()
        
        if liked {
            liked = false
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            liked = true
            Buzz.light()
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
    
}
