//
//  accountCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/27/21.
//

import UIKit

class settingsCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(title: String, index: Int) {
        titleLabel.text = title
        if index == 5 {
            titleLabel.textColor = .red
        }
    }

}
