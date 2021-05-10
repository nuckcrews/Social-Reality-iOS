//
//  searchUserMessageCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/9/21.
//

import UIKit

class searchUserMessageCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userFirstLastLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(user: UserModel) {
        
        userImageView.setImageFromURL(user.image)
        usernameLabel.text = user.username
        userFirstLastLabel.text = user.first + " " + user.last
        
    }

}
