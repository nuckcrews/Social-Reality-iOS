//
//  searchUserCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/24/21.
//

import UIKit

class searchUserCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userFirstLastLabel: UILabel!
    @IBOutlet weak var radioButton: UIButton!

    private var selectedUser = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(user: UserModel, selectedCell: Bool) {
        userImageView.setImageFromURL(user.image)
        usernameLabel.text = "@" + user.username
        userFirstLastLabel.text = user.first + " " + user.last
        
        if selectedCell {
            radioButton.tintColor = .primary
            radioButton.setImage(UIImage(systemName: "dot.square.fill"), for: .normal)
        } else {
            radioButton.tintColor = .grayText
            radioButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
            
    }
    
    func tapSelect() {
        if !selectedUser {
            selectedUser = true
            radioButton.tintColor = .primary
            radioButton.setImage(UIImage(systemName: "dot.square.fill"), for: .normal)
        } else {
            selectedUser = false
            radioButton.tintColor = .grayText
            radioButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }

}
