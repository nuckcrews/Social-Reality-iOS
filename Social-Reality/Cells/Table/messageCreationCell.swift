//
//  messageCreationCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/20/21.
//

import UIKit

// MARK: - Message Creation Cell

class messageCreationCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var leftMessageView: UIView!
    @IBOutlet weak var rightMessageView: UIView!
    @IBOutlet weak var leftContentLabel: UILabel!
    @IBOutlet weak var rightContentLabel: UILabel!
    @IBOutlet weak var leftCreationImageView: UIImageView!
    @IBOutlet weak var rightCreationImageView: UIImageView!
    @IBOutlet weak var leftCreationUserLabel: UILabel!
    @IBOutlet weak var rightCreationUserLabel: UILabel!
    @IBOutlet weak var leftCreationUserImageView: UIImageView!
    @IBOutlet weak var rightCreationUserImageView: UIImageView!
    
    // MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        rightMessageView.alpha = 0
        leftMessageView.alpha = 0
        
        rightCreationImageView.image = nil
        rightCreationUserImageView.image = nil
        
        leftCreationImageView.image = nil
        leftCreationUserImageView.image = nil
        
    }
    
    // MARK: - Configure Methods
    
    func configureCell(message: MessageModel) {
        
        if message.creationID == nil {
            
            if message.senderID == Auth0.uid {
                leftMessageView.alpha = 0
                rightMessageView.alpha = 1
                leftContentLabel.text = ""
                rightContentLabel.text = message.content
            } else {
                leftMessageView.alpha = 1
                rightMessageView.alpha = 0
                leftContentLabel.text = message.content
                rightContentLabel.text = ""
            }
            
        } else {
            
            if message.senderID == Auth0.uid {
                
                rightMessageView.alpha = 1
                rightContentLabel.text = message.creationCaption
                rightCreationImageView.setImageFromURL(message.creationImage)
                rightCreationUserImageView.setImageFromURL(message.creationUserImage)
                rightCreationUserLabel.text = message.creationUserName
                
                leftMessageView.alpha = 0
                leftContentLabel.text = ""
                leftCreationImageView.image = nil
                leftCreationUserImageView.image = nil
                leftCreationUserLabel.text = ""
                
            } else {
                
                leftMessageView.alpha = 1
                leftContentLabel.text = message.creationCaption
                leftCreationImageView.setImageFromURL(message.creationImage)
                leftCreationUserImageView.setImageFromURL(message.creationUserImage)
                leftCreationUserLabel.text = message.creationUserName
                
                rightMessageView.alpha = 0
                rightContentLabel.text = ""
                rightCreationImageView.image = nil
                rightCreationUserImageView.image = nil
                rightCreationUserLabel.text = ""
                
            }
            
        }
        
    }
    
}
