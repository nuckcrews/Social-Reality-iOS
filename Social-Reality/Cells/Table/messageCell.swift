//
//  messageCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/6/21.
//

import UIKit

class messageCell: UITableViewCell {

    @IBOutlet weak var leftMessageView: UIView!
    @IBOutlet weak var rightMessageView: UIView!
    @IBOutlet weak var leftContentLabel: UILabel!
    @IBOutlet weak var rightContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
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
