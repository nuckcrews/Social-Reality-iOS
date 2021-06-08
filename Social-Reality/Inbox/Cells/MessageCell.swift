//
//  MessageCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/6/21.
//

import UIKit

// MARK: - Message Cell

class MessageCell: UITableViewCell {
    
    // MARK: - Identifiers
    
    enum identifiers: String {
        case messageCell
    }

    // MARK: - Outlets
    
    @IBOutlet weak var leftMessageView: UIView!
    @IBOutlet weak var rightMessageView: UIView!
    @IBOutlet weak var leftContentLabel: UILabel!
    @IBOutlet weak var rightContentLabel: UILabel!
    
    // MARK: - cell Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        rightMessageView.alpha = 0
        leftMessageView.alpha = 0
        
    }
    
    // MARK: - Configure Methods
    
    func configureCell(message: MessageModel) {
        
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
        
    }
    
}
