//
//  CommentCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/26/21.
//

import UIKit

// MARK: - Comment Cell

class CommentCell: UITableViewCell {
    
    // MARK: - Identifiers
    
    enum identifiers: String {
        case commentCell
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Variables
    
    private var liked = false
    
    // MARK: - Cell Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Configure Methods
    
    func configureCell(comment: CommentModel, liked: Bool?) {
        
        likesCountLabel.text = ""
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
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
    }
    
}
